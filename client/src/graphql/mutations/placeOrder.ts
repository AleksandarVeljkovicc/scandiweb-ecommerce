export const PLACE_ORDER_MUTATION = `
  mutation PlaceOrder($orderJson: String!) {
    placeOrder(orderJson: $orderJson) {
      success
      message
    }
  }
`;
