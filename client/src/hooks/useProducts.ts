import { useEffect, useState } from 'react';
import { GET_PRODUCTS } from '../graphql/queries/getProducts';
import { graphqlRequest } from '../graphql/client';
import type { Product } from '../types/products';

export const useProducts = () => {
  const [products, setProducts] = useState<Product[] | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchProducts = async () => {
      try {
        const data = await graphqlRequest(GET_PRODUCTS);
        if (!data || !data.products) {
          throw new Error('No products returned from server');
        }
        setProducts(data.products);
      } catch (err: any) {
        setError(err.message || 'Unknown error');
      } finally {
        setLoading(false);
      }
    };

    fetchProducts();
  }, []);

  return { products, loading, error };
};
