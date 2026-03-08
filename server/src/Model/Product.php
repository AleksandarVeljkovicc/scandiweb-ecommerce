<?php
namespace App\Model;

class Product {
    public int $id;
    public ?string $name = null;
    public ?string $description = null;
    public ?float $price = null;
    public ?string $currency_symbol = null;
    public ?string $attribute_name = null;
    public ?string $value = null;
    public ?string $image_url = null;
    public ?string $category = null;
    public ?string $brand = null;
    public ?bool $in_stock = null;
    public ?string $code_name = null;

    // =======================
    // product
    // =======================
    public static function fromProduct(array $data): self {
        $p = new self();
        $p->id = (int)($data['id'] ?? 0);
        $p->name = $data['name'] ?? null;
        $p->description = $data['description'] ?? null;
        $p->category = $data['category'] ?? null;
        $p->brand = $data['brand'] ?? null;
        $p->in_stock = isset($data['in_stock']) ? self::parseInStock($data['in_stock']) : null;
        $p->code_name = $data['code_name'] ?? null;
        return $p;
    }

    private static function parseInStock(mixed $v): bool {
        return ($v === true || $v === 1 || $v === '1');
    }

    // =======================
    // Product Listing
    // =======================
    public static function fromListing(array $data): self {
        $p = new self();
        $p->id = (int)($data['product_id'] ?? 0);
        $p->name = $data['name'] ?? null;
        $p->price = isset($data['price']) ? (float)$data['price'] : null;
        $p->currency_symbol = $data['currency_symbol'] ?? null;
        $p->in_stock = isset($data['in_stock']) ? self::parseInStock($data['in_stock']) : null;
        $p->image_url = $data['image_url'] ?? null;
        return $p;
    }

    // =======================
    // Product Attribute View
    // =======================
    public static function fromAttribute(array $data): self {
        $p = new self();
        $p->id = (int)($data['product_id'] ?? 0);
        $p->name = $data['name'] ?? null;
        $p->price = isset($data['price']) ? (float)$data['price'] : null;
        $p->currency_symbol = $data['currency_symbol'] ?? null;
        $p->attribute_name = $data['attribute_name'] ?? null;
        $p->value = $data['value'] ?? null;
        $p->image_url = $data['image_url'] ?? null;
        return $p;
    }

    // =======================
    // Full Product View
    // =======================
    public static function fromFull(array $data): self {
        $p = new self();
        $p->id = (int)($data['product_id'] ?? 0);
        $p->name = $data['name'] ?? null;
        $p->price = isset($data['price']) ? (float)$data['price'] : null;
        $p->currency_symbol = $data['currency_symbol'] ?? null;
        $p->attribute_name = $data['attribute_name'] ?? null;
        $p->value = $data['value'] ?? null;
        $p->image_url = $data['image_url'] ?? null;
        $p->description = $data['description'] ?? null;
        if (array_key_exists('in_stock', $data)) {
            $p->in_stock = self::parseInStock($data['in_stock']);
        }
        return $p;
    }
}
