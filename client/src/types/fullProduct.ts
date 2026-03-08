export interface FullProduct {
  product_id: number;
  name: string;
  price: number;
  currency_symbol: string;
  attribute_name: string | null;
  value: string | null;
  image_url: string | null;
  description: string | null;
  in_stock?: boolean | null;
}
