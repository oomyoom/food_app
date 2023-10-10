const express = require("express");
const router = express.Router();
const { cartData } = require("../models/cart");
const { orderData } = require("../models/order");
const orderOperations = require("../controllers/orderOperations");
const orderRetrieval = require("../controllers/orderRetrieval");
const databaseUtils = require("../utils/databaseUtils");

router.post("/order", (req, res) => {
  databaseUtils.getLastId("order", "order_id", (error, lastOrderId) => {
    if (error) {
      return res.status(500).send("เกิดข้อผิดพลาดในการดึงค่า OrderId ล่าสุด");
    }

    orderOperations.insertOrder(
      orderData,
      lastOrderId,
      (error, lastOrderId) => {
        if (error) {
          return res.status(500).send("เกิดข้อผิดพลาดในการแทรกข้อมูลออเดอร์");
        }

        orderOperations.insertCart(cartData, lastOrderId, (error) => {
          if (error) {
            return res.status(500).send("เกิดข้อผิดพลาดในการแทรกข้อมูลตระกร้า");
          }

          res.status(200).send("ออเดอร์ถูกสร้างเรียบร้อยแล้ว");
        });
      }
    );
  });
});

router.patch("/order", (req, res) => {
  databaseUtils.updateColumn(
    "order",
    "isCompleted",
    "order_id",
    true,
    1,
    (error) => {
      if (error) {
        return res.status(500).send("เกิดข้อผิดพลาดในการอัปเดตข้อมูล");
      } else {
        res.status(200).send("ข้อมูลถูกอัปเดตเรียบร้อยแล้ว");
      }
    }
  );
});

router.get("/order", async (req, res) => {
  try {
    const allOrder = await orderRetrieval.retrieveOrder(1);
    res.status(200).json(allOrder);
  } catch (error) {
    console.error("เกิดข้อผิดพลาดในการดึงข้อมูล:", error);
    res.status(500).json({ error: "เกิดข้อผิดพลาดในการดึงข้อมูล" });
  }
});

module.exports = router;
