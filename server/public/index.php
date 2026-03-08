<?php

require_once __DIR__ . '/../vendor/autoload.php';

use Dotenv\Dotenv;
$dotenv = Dotenv::createImmutable(__DIR__ . '/..');
$dotenv->load();

$frontendOrigin = $_ENV['FRONTEND_ORIGIN'];

header("Access-Control-Allow-Origin: $frontendOrigin");
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Headers: Content-Type');
header('Access-Control-Allow-Methods: POST, OPTIONS');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

$dispatcher = FastRoute\simpleDispatcher(function(FastRoute\RouteCollector $r) {
    $r->post('/graphql', [App\Controller\GraphQL::class, 'handle']);
});

$routeInfo = $dispatcher->dispatch(
    $_SERVER['REQUEST_METHOD'],
    parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH)
);

switch ($routeInfo[0]) {
    case FastRoute\Dispatcher::NOT_FOUND:
        http_response_code(404);
        echo json_encode(['error' => 'Not Found']);
        break;
    case FastRoute\Dispatcher::METHOD_NOT_ALLOWED:
        $allowedMethods = $routeInfo[1];
        http_response_code(405);
        header('Allow: ' . implode(', ', $allowedMethods));
        echo json_encode(['error' => 'Method Not Allowed']);
        break;
    case FastRoute\Dispatcher::FOUND:
        $handler = $routeInfo[1];
        $vars = $routeInfo[2];
        try {
            call_user_func($handler);
        } catch (\Throwable $e) {
            error_log("[Router Error] " . $e->getMessage() . "\n" . $e->getTraceAsString());
            http_response_code(500);
            header('Content-Type: application/json; charset=UTF-8');
            echo json_encode(['errors' => [['message' => 'Server error', 'detail' => $e->getMessage()]]]);
        }
        break;
}
