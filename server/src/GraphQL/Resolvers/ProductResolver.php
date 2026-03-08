<?php
namespace App\GraphQL\Resolvers;

use App\Repository\ProductRepository;

class ProductResolver
{
    private ProductRepository $productRepository;

    public function __construct()
    {
        $this->productRepository = new ProductRepository();
    }

    // =======================
    // Product listing
    // =======================
    public function resolveAll(): array
    {
        return $this->productRepository->findAllForListing();
    }

    public function resolveById($root, $args)
    {
        return $this->productRepository->findById($args['id']);
    }

    // =======================
    // Product attributes
    // =======================
    public function resolveAllAttributes(): array
    {
        return $this->productRepository->findAllWithAttributes();
    }

    public function resolveAttributesByProductId($root, $args): array
    {
        return $this->productRepository->getByProductId($args['productId']);
    }

    // =======================
    // Full product view
    // =======================
    public function resolveAllFull(): array
    {
        return $this->productRepository->findAllFull();
    }

    public function resolveFullByProductId($root, $args): array
    {
        return $this->productRepository->findFullByProductId($args['id']);
    }
}
