import React, { useEffect, useMemo, useState } from "react";
import { useParams } from "react-router-dom";
import { FaAngleLeft, FaAngleRight } from "react-icons/fa6";
import "../assets/styles/product-page.css";
import { graphqlRequest } from "../graphql/client";
import type { FullProduct } from "../types/fullProduct";
import { GET_FULL_PRODUCT } from "../graphql/queries/getFullProduct";
import { useCart } from "../context/CartContext";
import type { ProductAttribute } from "../types/productAttribute";

const SIZE_DISPLAY: Record<string, string> = {
  Small: "S",
  Medium: "M",
  Large: "L",
  "Extra Large": "XL",
};

const COLOR_NAME_TO_HEX: Record<string, string> = {
  Green: "#44FF03",
  Cyan: "#03FFF7",
  Blue: "#030BFF",
  Black: "#000000",
  White: "#FFFFFF",
};

function getSizeDisplayLabel(val: string): string {
  return SIZE_DISPLAY[val] ?? val;
}

function getColorHex(val: string): string | null {
  const trimmed = val.trim();
  if (trimmed.startsWith("#")) return trimmed;
  return COLOR_NAME_TO_HEX[trimmed] ?? null;
}

function isColorValue(val: string): boolean {
  return val.trim().startsWith("#") || val.trim() in COLOR_NAME_TO_HEX;
}

interface ProductGrouped {
  product_id: number;
  name: string;
  price: number;
  currency_symbol: string;
  description: string | null;
  images: string[];
  attributes: { name: string; values: string[] }[];
  in_stock: boolean;
}

const ProductPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const { addToCart, openCart } = useCart();

  const [product, setProduct] = useState<ProductGrouped | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [mainIndex, setMainIndex] = useState(0);
  const [selectedValues, setSelectedValues] = useState<Record<string, string>>({});

  useEffect(() => {
    if (!id) return;
    setError(null);
    setLoading(true);

    graphqlRequest(GET_FULL_PRODUCT(Number(id)))
      .then((data) => {
        const fullData: FullProduct[] = data.fullProduct;
        if (!fullData || fullData.length === 0) {
          setError("Product not found");
          return;
        }

        const attrMap = new Map<string, Set<string>>();
        fullData.forEach((f: FullProduct) => {
          if (f.attribute_name && f.value) {
            if (!attrMap.has(f.attribute_name)) attrMap.set(f.attribute_name, new Set());
            attrMap.get(f.attribute_name)?.add(f.value);
          }
        });

        const grouped: ProductGrouped = {
          product_id: fullData[0].product_id,
          name: fullData[0].name,
          price: fullData[0].price,
          currency_symbol: fullData[0].currency_symbol,
          description: fullData[0].description,
          images: Array.from(
            new Set(fullData.map((f) => f.image_url).filter((url): url is string => !!url))
          ),
          attributes: Array.from(attrMap.entries()).map(
            ([name, values]): { name: string; values: string[] } => ({
              name,
              values: Array.from(values),
            })
          ),
          in_stock: fullData[0].in_stock === true,
        };

        setProduct(grouped);
      })
      .catch((err) => setError(err.message || "Error loading product"))
      .finally(() => setLoading(false));
  }, [id]);

  const descriptionNodes = useMemo(() => {
    const html = product?.description || "";
    if (!html.trim()) return null;

    if (typeof window === "undefined" || typeof DOMParser === "undefined") {
      return html;
    }

    const parser = new DOMParser();
    const doc = parser.parseFromString(html, "text/html");

    const transformNode = (node: ChildNode, index: number): React.ReactNode => {
      if (node.nodeType === Node.TEXT_NODE) {
        return node.textContent;
      }

      if (!(node instanceof HTMLElement)) return null;

      const children = Array.from(node.childNodes).map(transformNode);

      switch (node.tagName.toLowerCase()) {
        case "br":
          return <br key={index} />;
        case "strong":
        case "b":
          return <strong key={index}>{children}</strong>;
        case "em":
        case "i":
          return <em key={index}>{children}</em>;
        case "ul":
          return <ul key={index}>{children}</ul>;
        case "ol":
          return <ol key={index}>{children}</ol>;
        case "li":
          return <li key={index}>{children}</li>;
        case "p":
        default:
          return <span key={index}>{children}</span>;
      }
    };

    return Array.from(doc.body.childNodes).map(transformNode);
  }, [product?.description]);

  if (loading) return <p>Loading product...</p>;
  if (error) return <p className="error">Error: {error}</p>;
  if (!product) return <p>Product not found.</p>;

  const mainImageUrl = product.images[mainIndex] || "/fallback.jpg";

  const nextImage = () =>
    setMainIndex((prev) => (prev + 1) % product.images.length);
  const prevImage = () =>
    setMainIndex((prev) => (prev - 1 + product.images.length) % product.images.length);

  const handleSelect = (attrName: string, value: string) => {
    setSelectedValues((prev) => ({ ...prev, [attrName]: value }));
  };

  const handleAddToCart = () => {
    if (!product || !product.in_stock) return;

    const attributesForCart: Record<string, string[]> = {};
    product.attributes.forEach((attr: { name: string; values: string[] }) => {
      attributesForCart[attr.name] = attr.values;
    });

    const cartProduct: ProductAttribute = {
      product_id: product.product_id,
      name: product.name,
      price: product.price,
      currency_symbol: product.currency_symbol,
      attributes: attributesForCart,
      image_url: product.images[0] || "/fallback.jpg",
    };

    addToCart(cartProduct, selectedValues);
  };

  const allAttributesSelected =
    product.attributes.length === 0 ||
    product.attributes.every((attr) => !!selectedValues[attr.name]);
  const isInStock = product.in_stock;

  return (
    <main className="product-main">
      <section className="product-gallery" data-testid="product-gallery">
        <div className="gallery-thumbs">
          {product.images.map((img: string, i: number) => (
            <img
              key={i}
              src={img}
              alt={`Thumbnail ${i + 1}`}
              onClick={() => setMainIndex(i)}
              style={{ cursor: "pointer" }}
            />
          ))}
        </div>

        <div className="gallery-main">
          <img src={mainImageUrl} alt="Product" />
          <button className="nav-btn prev" onClick={prevImage}>
            <FaAngleLeft />
          </button>
          <button className="nav-btn next" onClick={nextImage}>
            <FaAngleRight />
          </button>
        </div>
      </section>

      <section className="product-info">
        <h2>{product.name}</h2>

        {product.attributes.map(
          (attr: { name: string; values: string[] }) => {
            const kebabName = attr.name
              .trim()
              .toLowerCase()
              .replace(/[^a-z0-9]+/g, "-")
              .replace(/^-+|-+$/g, "");
            const isColorAttr = attr.values.some((v) => typeof v === "string" && isColorValue(v));

            return (
              <div
                key={attr.name}
                className="option-block"
                data-testid={`product-attribute-${kebabName}`}
              >
                <span className="option-label">{attr.name}:</span>
                <div className={isColorAttr ? "color-list" : "size-list"}>
                  {attr.values.map((val: string, i: number) => {
                    const hex = getColorHex(val);
                    const isColor = hex !== null;
                    const isSelected = selectedValues[attr.name] === val;
                    if (isColor) {
                      return (
                        <div
                          key={i}
                          className={`color-swatch ${isSelected ? "selected" : ""}`}
                          style={{ backgroundColor: hex }}
                          onClick={() => handleSelect(attr.name, val)}
                          title={val}
                          role="button"
                          tabIndex={0}
                          onKeyDown={(e) => e.key === "Enter" && handleSelect(attr.name, val)}
                        />
                      );
                    }
                    return (
                      <button
                        key={i}
                        className={`size-btn ${isSelected ? "selected" : ""}`}
                        onClick={() => handleSelect(attr.name, val)}
                      >
                        {getSizeDisplayLabel(val)}
                      </button>
                    );
                  })}
                </div>
              </div>
            );
          }
        )}

        <span className="price-label">PRICE:</span>
        <p className="price-value">
          {product.currency_symbol}
          {product.price.toFixed(2)}
        </p>

        {!isInStock && (
          <p className="out-of-stock-pdp" role="status">
            Out of stock — add to cart is not available.
          </p>
        )}
        <button
          className="add-to-cart-btn"
          data-testid="add-to-cart"
          disabled={!allAttributesSelected || !isInStock}
          onClick={() => {
            handleAddToCart();
            openCart();
          }}
        >
          ADD TO CART
        </button>

        <div className="description" data-testid="product-description">
          {descriptionNodes}
        </div>
      </section>
    </main>
  );
};

export default ProductPage;
