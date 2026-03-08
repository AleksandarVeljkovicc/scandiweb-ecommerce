<?php
namespace App\GraphQL\Types;

use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;

class ProductType extends ObjectType {
    private static ?self $instance = null;

    public function __construct() {
        $config = [
            'name' => 'Product',
            'fields' => [
                // product
                'id' => Type::int(),
                'name' => Type::string(),
                'description' => Type::string(),
                'category' => Type::string(),
                'brand' => Type::string(),
                'in_stock' => Type::boolean(),
                'code_name' => Type::string(),

                // Listing / attributes
                'price' => Type::float(),

                // currency data checking
                'currency' => [
                    'type' => Type::string(),
                    'resolve' => function ($root) {
                        if (is_object($root) && property_exists($root, 'currency_symbol')) {
                            return $root->currency_symbol;
                        }
                        if (is_array($root) && isset($root['currency_symbol'])) {
                            return $root['currency_symbol'];
                        }
                        return null;
                    },
                ],

                'currency_symbol' => Type::string(),
                'attribute_name' => Type::string(),
                'value' => Type::string(),
                'image_url' => Type::string(),

                // Full product
                'product_id' => [
                    'type' => Type::int(),
                    'resolve' => function ($root) {
                        if (is_object($root) && property_exists($root, 'id')) {
                            return $root->id;
                        }
                        if (is_array($root) && isset($root['id'])) {
                            return $root['id'];
                        }
                        return null;
                    },
                ],
            ],
        ];

        parent::__construct($config);
    }

    public static function get(): self {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }
}
