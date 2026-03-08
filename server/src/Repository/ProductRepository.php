<?php
namespace App\Repository;

use App\Config\Database;
use App\Model\Product;
use PDO;

class ProductRepository
{
    public function findAll(): array
    {
        $conn = Database::getConnection();
        $stmt = $conn->query("SELECT * FROM products");
        $rows = $stmt->fetchAll();

        $products = [];
        foreach ($rows as $row) {
            $products[] = Product::fromProduct($row);
        }
        return $products;
    }

    public function findById(int $id): ?Product
    {
        $conn = Database::getConnection();
        $stmt = $conn->prepare("SELECT * FROM products WHERE id = :id");
        $stmt->execute(['id' => $id]);
        $row = $stmt->fetch();

        if (!$row) return null;
        return Product::fromProduct($row);
    }

    public function findAllForListing(): array
    {
        $conn = Database::getConnection();
        $stmt = $conn->query("SELECT * FROM product_listing_view");
        $rows = $stmt->fetchAll();

        $products = [];
        foreach ($rows as $row) {
            $products[] = Product::fromListing($row);
        }
        return $products;
    }

    public function findAllWithAttributes(): array
    {
        $conn = Database::getConnection();
        $stmt = $conn->query("SELECT * FROM view_product_attributes");
        $rows = $stmt->fetchAll();

        $products = [];
        foreach ($rows as $row) {
            $products[] = Product::fromAttribute($row);
        }
        return $products;
    }

    public function getByProductId(int $productId): array
    {
        $conn = Database::getConnection();
        $stmt = $conn->prepare("
            SELECT
                product_id,
                name,
                price,
                currency_symbol,
                attribute_name,
                value,
                image_url
            FROM view_product_attributes
            WHERE product_id = :product_id
        ");
        $stmt->execute(['product_id' => $productId]);

        $rows = $stmt->fetchAll();

        $products = [];
        foreach ($rows as $row) {
            $products[] = Product::fromAttribute($row);
        }
        return $products;
    }

    public function findAllFull(): array
    {
        $conn = Database::getConnection();
        $stmt = $conn->query("SELECT * FROM full_product");
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $products = [];
        foreach ($rows as $row) {
            $products[] = Product::fromFull($row);
        }
        return $products;
    }

    public function findFullByProductId(int $id): array
    {
        $conn = Database::getConnection();
        $stmt = $conn->prepare("SELECT * FROM full_product WHERE product_id = :id");
        $stmt->execute(['id' => $id]);
        $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

        $products = [];
        foreach ($rows as $row) {
            $products[] = Product::fromFull($row);
        }
        return $products;
    }
}
