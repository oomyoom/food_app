const { db } = require("../config/database");
const databaseUtils = require("../utils/databaseUtils");

async function retrieveOrder(uid) {
  const allOrder = [];

  try {
    const orderQuery = `SELECT * FROM \`order\` WHERE uid = ${uid}`;
    const orderResults = await databaseUtils.getDataFromDB(orderQuery);

    if (orderResults.length > 0) {
      for (let i = 0; i < orderResults.length; i++) {
        const cartQuery = `SELECT * FROM cart WHERE order_id = ${orderResults[i].order_id}`;
        const cartResults = await databaseUtils.getDataFromDB(cartQuery);

        if (cartResults.length > 0) {
          for (let j = 0; j < cartResults.length; j++) {
            const menuQuery = `SELECT * FROM menu WHERE menu_id = ${cartResults[j].menu_id}`;
            const [menuResults] = await databaseUtils.getDataFromDB(menuQuery);

            delete cartResults[j].menu_id, delete cartResults[j].order_id;
            cartResults[j].menu = menuResults;
          }
        }
        orderResults[i].cart = cartResults;
        allOrder.push(orderResults[i]);
      }
    }
    return allOrder;
  } catch (error) {
    throw error;
  }
}

module.exports = { retrieveOrder };
