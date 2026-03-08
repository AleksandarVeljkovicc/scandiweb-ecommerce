import React, { createContext, useState, useContext, useEffect } from "react";
import type { ReactNode } from "react";
import type { ProductAttribute } from "../types/productAttribute";

interface CartItem extends ProductAttribute {
  qty: number;
  selectedAttributes: { [key: string]: string };
}

interface CartContextType {
  cartItems: CartItem[];
  addToCart: (product: ProductAttribute, selectedAttributes: { [key: string]: string }) => void;
  increaseQty: (productId: number, selectedAttributes: { [key: string]: string }) => void;
  decreaseQty: (productId: number, selectedAttributes: { [key: string]: string }) => void;
  cartCount: number;
  clearCart: () => void;
  isCartOpen: boolean;
  openCart: () => void;
  closeCart: () => void;
  toggleCart: () => void;
}

const CartContext = createContext<CartContextType | undefined>(undefined);

export const CartProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [cartItems, setCartItems] = useState<CartItem[]>(() => {
    try {
      const saved = localStorage.getItem("cartItems");
      return saved ? JSON.parse(saved) : [];
    } catch {
      return [];
    }
  });
  const [isCartOpen, setIsCartOpen] = useState(false);

  useEffect(() => {
    try {
      localStorage.setItem("cartItems", JSON.stringify(cartItems));
    } catch {
      // Ignore quota or serialization errors; cart remains in state
    }
  }, [cartItems]);

  const addToCart = (product: ProductAttribute, selectedAttributes: { [key: string]: string }) => {
    setCartItems((prev) => {
      const existing = prev.find(
        (i) =>
          i.product_id === product.product_id &&
          JSON.stringify(i.selectedAttributes) === JSON.stringify(selectedAttributes)
      );
      if (existing) {
        return prev.map((i) =>
          i.product_id === product.product_id &&
          JSON.stringify(i.selectedAttributes) === JSON.stringify(selectedAttributes)
            ? { ...i, qty: i.qty + 1 }
            : i
        );
      }
      return [...prev, { ...product, qty: 1, selectedAttributes }];
    });
  };

  const increaseQty = (productId: number, selectedAttributes: { [key: string]: string }) => {
    setCartItems((prev) =>
      prev.map((item) =>
        item.product_id === productId &&
        JSON.stringify(item.selectedAttributes) === JSON.stringify(selectedAttributes)
          ? { ...item, qty: item.qty + 1 }
          : item
      )
    );
  };

  const decreaseQty = (productId: number, selectedAttributes: { [key: string]: string }) => {
    setCartItems((prev) =>
      prev
        .map((item) =>
          item.product_id === productId &&
          JSON.stringify(item.selectedAttributes) === JSON.stringify(selectedAttributes)
            ? { ...item, qty: item.qty - 1 }
            : item
        )
        .filter((item) => item.qty > 0)
    );
  };

  const clearCart = () => {
    setCartItems([]);
    localStorage.removeItem("cartItems");
  };

  const cartCount = cartItems.reduce((sum, item) => sum + item.qty, 0);

  return (
    <CartContext.Provider
      value={{
        cartItems,
        addToCart,
        increaseQty,
        decreaseQty,
        cartCount,
        clearCart,
        isCartOpen,
        openCart: () => setIsCartOpen(true),
        closeCart: () => setIsCartOpen(false),
        toggleCart: () => setIsCartOpen((prev) => !prev),
      }}
    >
      {children}
    </CartContext.Provider>
  );
};

export const useCart = (): CartContextType => {
  const context = useContext(CartContext);
  if (!context) {
    throw new Error("useCart must be used within a CartProvider");
  }
  return context;
};
