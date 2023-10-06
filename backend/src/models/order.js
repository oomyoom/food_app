const { cartData } = require("./cart");

const orderData = {
  order_total: 16,
  createDateTime: new Date().toISOString().slice(0, 19).replace("T", " "),
  deliveryOption: "Take-Away",
  isCompleted: false,
};

module.exports = { orderData };
