<?php

namespace App\Controller;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use GraphQL\Type\Schema;
use GraphQL\GraphQL as GraphQLBase;
use App\GraphQL\Types\ProductType;
use App\GraphQL\Resolvers\ProductResolver;
use App\GraphQL\Resolvers\OrderResolver;
use App\Repository\ProductRepository;
use App\Config\Database;
use RuntimeException;
use Throwable;

class GraphQL
{
    public static function handle()
    {
        ini_set('display_errors', '1');
        ini_set('display_startup_errors', '1');
        error_reporting(E_ALL);

        $frontendOrigin = $_ENV['FRONTEND_ORIGIN'];

        header("Access-Control-Allow-Origin: $frontendOrigin");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Allow-Headers: Content-Type');
        header('Access-Control-Allow-Methods: POST, OPTIONS');

        if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
            http_response_code(200);
            exit();
        }

        $logFile = __DIR__ . '/../../logs/graphql_errors.log';
        if (!is_dir(dirname($logFile))) {
            @mkdir(dirname($logFile), 0777, true);
        }

        try {
            $pdo = Database::getConnection();
        } catch (\PDOException $e) {
            http_response_code(500);
            $msg = 'Database connection failed: ' . $e->getMessage();
            error_log("[" . date('c') . "] DB ERROR: " . $msg . PHP_EOL, 3, $logFile);
            echo json_encode(['errors' => [['message' => $msg]]]);
            exit;
        }

        try {
            $productResolver = new ProductResolver();

            $queryType = new ObjectType([
                'name' => 'Query',
                'fields' => [
                    'products' => [
                        'type' => Type::listOf(ProductType::get()),
                        'resolve' => fn() => $productResolver->resolveAll(),
                    ],
                    'product' => [
                        'type' => ProductType::get(),
                        'args' => [
                            'id' => Type::nonNull(Type::int()),
                        ],
                        'resolve' => fn($root, $args) => (new ProductRepository())->findById($args['id']),
                    ],
                    'fullProduct' => [
                        'type' => Type::listOf(ProductType::get()),
                        'args' => ['id' => Type::nonNull(Type::int())],
                        'resolve' => fn($root, $args) => $productResolver->resolveFullByProductId($root, $args),
                    ],
                    'fullProducts' => [
                        'type' => Type::listOf(ProductType::get()),
                        'resolve' => fn() => $productResolver->resolveAll(),
                    ],
                   'productAttributes' => [
                        'type' => Type::listOf(ProductType::get()),
                        'args' => ['productId' => Type::int()],
                        'resolve' => fn($root, $args) => $productResolver->resolveAttributesByProductId($root, $args),
                    ],
                ],
            ]);

            $orderResponseType = new ObjectType([
                'name' => 'OrderResponse',
                'fields' => [
                    'success' => Type::nonNull(Type::boolean()),
                    'message' => Type::nonNull(Type::string()),
                ],
            ]);

            $mutationType = new ObjectType([
                'name' => 'Mutation',
                'fields' => [
                    'placeOrder' => [
                        'type' => $orderResponseType,
                        'args' => [
                            'orderJson' => Type::nonNull(Type::string()),
                            'userId' => Type::int(),
                        ],
                        'resolve' => fn($root, $args) => (new OrderResolver())->placeOrder($root, $args),
                    ],
                ],
            ]);

            $schema = new Schema([
                'query' => $queryType,
                'mutation' => $mutationType,
            ]);

            $rawInput = file_get_contents('php://input');
            if ($rawInput === false) {
                throw new RuntimeException('Failed to get php://input');
            }

            $input = json_decode($rawInput, true);
            if (!is_array($input) || !isset($input['query'])) {
                throw new RuntimeException('Invalid or missing GraphQL query');
            }

            error_log("[" . date('c') . "] Incoming query: " . $input['query'] . PHP_EOL, 3, $logFile);
            if (!empty($input['variables'])) {
                error_log("[" . date('c') . "] Variables: " . json_encode($input['variables']) . PHP_EOL, 3, $logFile);
            }

            $result = GraphQLBase::executeQuery(
                $schema,
                $input['query'],
                null,
                null,
                $input['variables'] ?? null
            );

            $output = $result->toArray(true);

            if (!empty($result->errors)) {
                foreach ($result->errors as $error) {
                    $logEntry = "[" . date('c') . "] GraphQL ERROR: " . $error->getMessage() . PHP_EOL;
                    if (method_exists($error, 'getTraceAsString')) {
                        $logEntry .= "Trace: " . $error->getTraceAsString() . PHP_EOL;
                    }
                    $logEntry .= "Query: " . $input['query'] . PHP_EOL;
                    if (!empty($input['variables'])) {
                        $logEntry .= "Variables: " . json_encode($input['variables']) . PHP_EOL;
                    }
                    $logEntry .= str_repeat('-', 80) . PHP_EOL;
                    error_log($logEntry, 3, $logFile);
                }
            }

        } catch (Throwable $e) {
            $logEntry = "[" . date('c') . "] Exception: " . $e->getMessage() . PHP_EOL;
            $logEntry .= "Input: " . ($rawInput ?? '') . PHP_EOL;
            $logEntry .= "Trace: " . $e->getTraceAsString() . PHP_EOL;
            $logEntry .= str_repeat('-', 80) . PHP_EOL;
            error_log($logEntry, 3, $logFile);

            $output = [
                'errors' => [[
                    'message' => $e->getMessage(),
                    'trace'   => $e->getTraceAsString(),
                ]]
            ];
        }

        header('Content-Type: application/json; charset=UTF-8');
        echo json_encode($output);
    }
}
