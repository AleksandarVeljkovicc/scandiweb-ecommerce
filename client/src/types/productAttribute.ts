export interface ProductAttribute {
  product_id: number;
  name: string;
  price: number;
  currency_symbol: string;
  image_url: string | null;
  attributes: Record<string, (string | number)[]>; // 🔑 ovako
}
