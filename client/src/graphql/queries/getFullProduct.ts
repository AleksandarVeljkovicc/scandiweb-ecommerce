export const GET_FULL_PRODUCT = (id: number): string => `
  query {
    fullProduct(id: ${id}) {
      product_id
      name
      price
      currency_symbol
      in_stock
      attribute_name
      value
      image_url
      description
    }
  }
`;
