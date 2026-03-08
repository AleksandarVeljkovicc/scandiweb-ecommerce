<?php

declare(strict_types=1);

namespace App\Repository;

use App\Config\Database;
use PDO;

class OrderRepository
{
    private const DEFAULT_GUEST_USER_ID = 1;

    /**
     * @param int $userId
     * @param array<int, array{product_id: int, quantity: int, total_price: float, currency_symbol: string, attributes: array<string, string>}> $cartLines
     */
    public function insertFromCart(int $userId, array $cartLines): void
    {
        $userId = $userId > 0 ? $userId : self::DEFAULT_GUEST_USER_ID;
        $conn = Database::getConnection();

        $stmtOrder = $conn->prepare(
            'INSERT INTO orders (users_id, product_id, total_price, currency_symbol, quantity) VALUES (?, ?, ?, ?, ?)'
        );
        $stmtAttr = $conn->prepare(
            'INSERT INTO order_attributes (orders_id, attribute_name, value) VALUES (?, ?, ?)'
        );

        foreach ($cartLines as $line) {
            $productId = (int) ($line['product_id'] ?? 0);
            $quantity = (int) ($line['quantity'] ?? 1);
            $totalPrice = (float) ($line['total_price'] ?? 0);
            $currency = is_string($line['currency_symbol'] ?? null) ? $line['currency_symbol'] : '$';
            $attributes = is_array($line['attributes'] ?? null) ? $line['attributes'] : [];

            $stmtOrder->execute([$userId, $productId, $totalPrice, $currency, $quantity]);
            $orderId = (int) $conn->lastInsertId();

            foreach ($attributes as $attrName => $attrValue) {
                if (is_string($attrName) && (is_string($attrValue) || is_numeric($attrValue))) {
                    $stmtAttr->execute([$orderId, $attrName, (string) $attrValue]);
                }
            }
        }
    }
}
