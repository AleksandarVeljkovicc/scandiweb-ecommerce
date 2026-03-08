<?php

declare(strict_types=1);

namespace App\GraphQL\Resolvers;

use App\Repository\OrderRepository;

class OrderResolver
{
    /**
     * @param mixed $root
     * @param array<string, mixed> $args
     * @return array{success: bool, message: string}
     */
    public function placeOrder($root, array $args): array
    {
        $orderJson = $args['orderJson'] ?? '';
        $userId = isset($args['userId']) ? (int) $args['userId'] : 1;

        if (!is_string($orderJson) || $orderJson === '') {
            return ['success' => false, 'message' => 'Empty order data.'];
        }

        $decoded = json_decode($orderJson, true);
        if (!is_array($decoded)) {
            return ['success' => false, 'message' => 'Invalid order format.'];
        }

        $cartLines = [];
        foreach ($decoded as $item) {
            if (!is_array($item) || !isset($item['product_id'])) {
                continue;
            }
            $cartLines[] = [
                'product_id' => (int) $item['product_id'],
                'quantity' => (int) ($item['quantity'] ?? 1),
                'total_price' => (float) ($item['total_price'] ?? 0),
                'currency_symbol' => isset($item['currency_symbol']) && is_string($item['currency_symbol'])
                    ? $item['currency_symbol'] : '$',
                'attributes' => is_array($item['attributes'] ?? null) ? $item['attributes'] : [],
            ];
        }

        if ($cartLines === []) {
            return ['success' => false, 'message' => 'No items to order.'];
        }

        try {
            (new OrderRepository())->insertFromCart($userId, $cartLines);
            return ['success' => true, 'message' => 'Order placed successfully.'];
        } catch (\Throwable $e) {
            return ['success' => false, 'message' => 'Failed to save order.'];
        }
    }
}
