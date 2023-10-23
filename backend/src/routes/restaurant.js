const express = require("express");
const router = express.Router();
const databaseUtils = require("../utils/databaseUtils");

router.get("/get", async (req, res) => {
  try {
    const restaurant = await databaseUtils.getDataFromDB(
      `SELECT available FROM \`restaurant\``
    );
    res.status(200).json(restaurant);
  } catch (error) {
    console.error("เกิดข้อผิดพลาดในการดึงข้อมูล:", error);
    res.status(500).json({ error: "เกิดข้อผิดพลาดในการดึงข้อมูล" });
  }
});

module.exports = router;
