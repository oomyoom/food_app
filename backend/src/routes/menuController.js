//ของร้านอาหาร
const express = require("express");
const router = express.Router();
const { menuData } = require("../models/menu");
const menuOperations = require("../controllers/menuOperations");
const menuRetrieval = require("../controllers/menuRetrieval");
const databaseUtils = require("../utils/databaseUtils");

router.post("/menu", (req, res) => {
  databaseUtils.getLastId("menu", "menu_id", (error, lastMenuId) => {
    if (error) {
      return res.status(500).send("เกิดข้อผิดพลาดในการดึงค่า MenuId ล่าสุด");
    }

    databaseUtils.getLastId("mcategory", "category_id", (error, lastCateId) => {
      if (error) {
        return res
          .status(500)
          .send("เกิดข้อผิดพลาดในการดึงค่า CategoryId ล่าสุด");
      }

      menuOperations.insertMenu(menuData, lastMenuId, (error, lastMenuId) => {
        if (error) {
          return res.status(500).send("เกิดข้อผิดพลาดในการแทรกข้อมูลเมนู");
        }

        menuOperations.insertCategory(
          menuData.categories,
          lastMenuId,
          lastCateId,
          (error, lastCateId) => {
            if (error) {
              return res
                .status(500)
                .send("เกิดข้อผิดพลาดในการแทรกข้อมูลหมวดหมู่");
            }

            menuOperations.insertOption(
              menuData.categories,
              lastCateId,
              (error) => {
                if (error) {
                  return res
                    .status(500)
                    .send("เกิดข้อผิดพลาดในการแทรกข้อมูลตัวเลือก");
                }

                res.status(200).send("เมนูถูกสร้างเรียบร้อยแล้ว");
              }
            );
          }
        );
      });
    });
  });
});

router.get("/menu", async (req, res) => {
  try {
    const allMenu = await menuRetrieval.retrieveMenu();
    res.status(200).json(allMenu);
  } catch (error) {
    console.error("เกิดข้อผิดพลาดในการดึงข้อมูล:", error);
    res.status(500).json({ error: "เกิดข้อผิดพลาดในการดึงข้อมูล" });
  }
});

module.exports = router;
