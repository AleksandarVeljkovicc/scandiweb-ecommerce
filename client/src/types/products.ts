export interface Product {
  id: number;
  name: string;
  price: number;
  currency: string;
  in_stock: boolean;
  image_url?: string;
}
