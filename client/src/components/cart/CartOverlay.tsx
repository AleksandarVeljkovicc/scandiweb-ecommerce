import React, { useState } from "react";
import "../../assets/styles/cart-overlay.css";
import { useCart } from "../../context/CartContext";
import { graphqlRequest } from "../../graphql/client";
import { PLACE_ORDER_MUTATION } from "../../graphql/mutations/placeOrder";

interface CartOverlayProps {
  isOpen: boolean;
  onClose: () => void;
}

const OrderSuccessModal: React.FC<{ onClose: () => void }> = ({ onClose }) => (
  <>
    <div className="cart-backdrop" onClick={onClose} />
    <div className="order-modal">
      <div className="order-modal-content">
        <h3>Order successful!</h3>
        <p>Your order has been placed.</p>
        <button className="ok-btn" onClick={onClose}>OK</button>
      </div>
    </div>
  </>
);

const toKebabCase = (value: string): string =>
  value
    .trim()
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");

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

function getColorHex(val: string): string | null {
  const t = val.trim();
  if (t.startsWith("#")) return t;
  return COLOR_NAME_TO_HEX[t] ?? null;
}

function getSizeDisplayLabel(val: string): string {
  return SIZE_DISPLAY[val] ?? val;
}

const CartOverlay: React.FC<CartOverlayProps> = ({ isOpen, onClose }) => {
  const { cartItems, increaseQty, decreaseQty, clearCart } = useCart();
  const [modalOpen, setModalOpen] = useState(false);
  const [placing, setPlacing] = useState(false);

  if (!isOpen) return null;

  const total = cartItems.reduce((sum, item) => sum + item.price * item.qty, 0);
  const totalItems = cartItems.reduce((s, i) => s + i.qty, 0);
  const totalItemsLabel = `${totalItems} ${totalItems === 1 ? "Item" : "Items"}`;

  const handlePlaceOrder = async () => {
    if (!cartItems || cartItems.length === 0) return;
    setPlacing(true);
    try {
      const orderPayload = cartItems.map((item) => ({
        product_id: item.product_id,
        quantity: item.qty,
        total_price: item.price * item.qty,
        currency_symbol: item.currency_symbol ?? "$",
        attributes: item.selectedAttributes ?? {},
      }));
      const data = await graphqlRequest(PLACE_ORDER_MUTATION, {
        orderJson: JSON.stringify(orderPayload),
      });
      const result = data?.placeOrder;
      if (result?.success) {
        clearCart();
        setModalOpen(true);
      }
    } catch {
      // Keep cart on error; user can retry
    } finally {
      setPlacing(false);
    }
  };

  const handleModalOk = () => {
    setModalOpen(false);
    onClose();
  };

  return (
    <>
      <div className="cart-backdrop" onClick={onClose} />
      <aside className="cart-overlay">
        <h4 className="cart-title">
          My Bag, <span>{totalItemsLabel}</span>
        </h4>

        <ul className="cart-items">
          {cartItems.map((item) => (
            <li key={`${item.product_id}-${JSON.stringify(item.selectedAttributes)}`} className="cart-item">
              <div className="cart-item-info">
                <p className="cart-item-name">{item.name}</p>
                <p className="cart-item-price">
                  {item.currency_symbol} {(item.price * item.qty).toFixed(2)}
                </p>

                {Object.entries(item.attributes).map(([attrName, values]) => (
                  <div
                    key={attrName}
                    className="cart-item-attr"
                    data-testid={`cart-item-attribute-${toKebabCase(attrName)}`}
                  >
                    <span className="attr-label">{attrName}:</span>
                    <div className="attr-group">
                      {Array.isArray(values) &&
                        values.map((val: string | number) => {
                          const stringVal = String(val).trim();
                          const hex = getColorHex(stringVal);
                          const isColor = hex !== null;
                          const isSelected = item.selectedAttributes?.[attrName] === stringVal;
                          const baseTestId = `cart-item-attribute-${toKebabCase(
                            attrName,
                          )}-${toKebabCase(attrName)}`;
                          if (isColor) {
                            return (
                              <div
                                key={stringVal}
                                className={`color-swatch ${isSelected ? "selected" : ""}`}
                                style={{ backgroundColor: hex }}
                                data-testid={
                                  isSelected ? `${baseTestId}-selected` : baseTestId
                                }
                                title={stringVal}
                              />
                            );
                          }
                          return (
                            <div
                              key={stringVal}
                              className={`size-box ${isSelected ? "selected" : ""}`}
                              data-testid={
                                isSelected ? `${baseTestId}-selected` : baseTestId
                              }
                            >
                              {getSizeDisplayLabel(stringVal)}
                            </div>
                          );
                        })}
                    </div>
                  </div>
                ))}
              </div>

              <div className="cart-item-right">
                <div className="cart-item-controls">
                  <button
                    className="qty-btn"
                    data-testid="cart-item-amount-increase"
                    onClick={() => increaseQty(item.product_id, item.selectedAttributes)}
                  >
                    +
                  </button>
                  <span className="qty-number" data-testid="cart-item-amount">
                    {item.qty}
                  </span>
                  <button
                    className="qty-btn"
                    data-testid="cart-item-amount-decrease"
                    onClick={() => decreaseQty(item.product_id, item.selectedAttributes)}
                  >
                    –
                  </button>
                </div>
                <img src={item.image_url || "/fallback.jpg"} alt={item.name} className="cart-item-img" loading="lazy" />
              </div>
            </li>
          ))}
        </ul>

        <div className="cart-total" data-testid="cart-total">
          <span>Total</span>
          <span>{cartItems[0]?.currency_symbol ?? ""} {total.toFixed(2)}</span>
        </div>

        <button
          type="button"
          className="place-order-btn"
          onClick={handlePlaceOrder}
          disabled={cartItems.length === 0 || placing}
        >
          PLACE ORDER
        </button>
      </aside>

      {modalOpen && <OrderSuccessModal onClose={handleModalOk} />}
    </>
  );
};

export default CartOverlay;
