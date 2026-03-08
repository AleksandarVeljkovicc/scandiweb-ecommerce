import "../assets/styles/category-page.css";
import { useProducts } from "../hooks/useProducts";
import { useNavigate, useParams } from "react-router-dom";
import type { Product } from "../types/products";
import cartIcon from "../assets/images/cart-icon.jpg";
import { useCart } from "../context/CartContext";
import { graphqlRequest } from "../graphql/client";
import { GET_FULL_PRODUCT } from "../graphql/queries/getFullProduct";
import type { FullProduct } from "../types/fullProduct";

const CATEGORY_TITLES: Record<string, string> = {
  women: "Women",
  men: "Men",
  kids: "Kids",
};

const toKebabCase = (value: string): string =>
  value
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");

const CategoryPage = () => {
  const { category } = useParams<{ category?: string }>();
  const { products, loading, error } = useProducts();
  const navigate = useNavigate();
  const { addToCart } = useCart();
  const categoryTitle = (category && CATEGORY_TITLES[category]) ? CATEGORY_TITLES[category] : "Women";

  const handleQuickShop = async (productId: number) => {
    try {
      const data = await graphqlRequest(GET_FULL_PRODUCT(productId));
      const fullData: FullProduct[] = data.fullProduct;
      if (!fullData || fullData.length === 0) return;

      const attrMap = new Map<string, Set<string>>();
      fullData.forEach((f: FullProduct) => {
        if (f.attribute_name && f.value) {
          if (!attrMap.has(f.attribute_name)) attrMap.set(f.attribute_name, new Set());
          attrMap.get(f.attribute_name)!.add(f.value);
        }
      });

      const attributesForCart: Record<string, string[]> = {};
      const selectedValues: Record<string, string> = {};
      Array.from(attrMap.entries()).forEach(([name, values]) => {
        const arr = Array.from(values);
        attributesForCart[name] = arr;
        if (arr.length > 0) selectedValues[name] = arr[0];
      });

      const first = fullData[0];
      const cartProduct = {
        product_id: first.product_id,
        name: first.name,
        price: first.price,
        currency_symbol: first.currency_symbol,
        attributes: attributesForCart,
        image_url: first.image_url || "/fallback.jpg",
      };

      addToCart(cartProduct, selectedValues);
    } catch (err) {
      console.error("Quick shop error", err);
    }
  };

  if (loading) return <p>Loading...</p>;
  if (error) return <p className="error">Error: {error}</p>;
  if (!products || products.length === 0) return <p>No products found.</p>;

  return (
    <main className="category-main">
      <h1 className="category-title">{categoryTitle}</h1>
      <div className="product-grid">
        {products.map((product: Product) => {
          const { id, name, price, currency, in_stock, image_url } = product;
          const kebabName = toKebabCase(name);

          return (
            <div
              key={id}
              className={`product-card ${!in_stock ? "out-of-stock" : ""}`}
              data-testid={`product-${kebabName}`}
              onClick={() => navigate(`/product/${id}`)}
            >
              <div className="img-wrapper">
                <img
                  src={image_url || "/fallback.jpg"}
                  alt={name}
                  className="product-image"
                />

                {!in_stock && (
                  <span className="out-of-stock-label">OUT OF STOCK</span>
                )}

                {in_stock && (
                  <button
                    className="cart-btn"
                    aria-label={`Open product ${id}`}
                    onClick={(e) => {
                      e.stopPropagation();
                      void handleQuickShop(id);
                    }}
                  >
                    <img src={cartIcon} alt="Cart" className="cart-icon" />
                  </button>
                )}
              </div>

              <p className="product-name">{name}</p>
              <p className="product-price">
                {currency}
                {Number(price).toFixed(2)}
              </p>
            </div>
          );
        })}
      </div>
    </main>
  );
};

export default CategoryPage;
