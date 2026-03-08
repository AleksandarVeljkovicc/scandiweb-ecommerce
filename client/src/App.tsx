import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import CategoryPage from "./pages/CategoryPage";
import ProductPage from "./pages/ProductPage";
import Header from "./components/layout/Header";
import { CartProvider } from "./context/CartContext";

const App = () => (
  <CartProvider>
    <Router>
      <Header />
      <Routes>
        <Route path="/" element={<Navigate to="/shop/women" replace />} />
        <Route path="/shop" element={<Navigate to="/shop/women" replace />} />
        <Route path="/shop/:category" element={<CategoryPage />} />
        <Route path="/product/:id" element={<ProductPage />} />
      </Routes>
    </Router>
  </CartProvider>
);

export default App;
