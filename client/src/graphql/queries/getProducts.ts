export const GET_PRODUCTS = `
  query {
    products {
      id
      name
      price
      currency
      in_stock
      image_url
    }
  }
`;
