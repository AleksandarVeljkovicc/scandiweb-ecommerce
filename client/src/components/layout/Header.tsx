import { useMemo } from "react";
import { useNavigate, useParams } from "react-router-dom";
import CartOverlay from "../cart/CartOverlay";
import { useCart } from "../../context/CartContext";
import "../../assets/styles/header.css";
import middleIcon from "../../assets/images/middle-icon.png";
import cartIcon from "../../assets/images/cart-icon.jpg";

const CATEGORIES = [
  { key: "women", label: "WOMEN" },
  { key: "men", label: "MEN" },
  { key: "kids", label: "KIDS" },
] as const;

const Header = () => {
  const { category } = useParams<{ category?: string }>();
  const activeCategory = (category && CATEGORIES.some((c) => c.key === category) ? category : "women") as "women" | "men" | "kids";
  const { cartCount, isCartOpen, toggleCart, closeCart } = useCart();
  const navigate = useNavigate();

  return (
    <>
      <header className="main-header">
        <div className="header-left">
          <nav className="category-nav" aria-label="Categories">
            {CATEGORIES.map((c) => {
              const isActive = c.key === activeCategory;
              return (
                <button
                  key={c.key}
                  type="button"
                  className={`category-nav-link ${isActive ? "active" : ""}`}
                  data-testid={isActive ? "active-category-link" : "category-link"}
                  onClick={() => navigate(`/shop/${c.key}`)}
                >
                  {c.label}
                </button>
              );
            })}
          </nav>
        </div>

        <div className="header-center">
          <img
            src={middleIcon}
            alt=""
            className="header-middle-icon"
            onClick={() => navigate("/shop/women")}
          />
        </div>

        <div className="header-right">
          <div
            className="cart-icon-wrapper"
            data-testid="cart-btn"
            onClick={toggleCart}
          >
            <img src={cartIcon} alt="Cart" className="cart-icon" />
            {cartCount > 0 && <span className="cart-count">{cartCount}</span>}
          </div>
        </div>
      </header>

      <div className="header-spacer"></div>

      <CartOverlay isOpen={isCartOpen} onClose={closeCart} />
    </>
  );
};

export default Header;
