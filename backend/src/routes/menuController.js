//ของร้านอาหาร
const express = require("express");
const router = express.Router();
const { menuData } = require("../models/menu");
const menuOperations = require("../controllers/menuOperations");

router.post("/menuv2", (req, res) => {
  menuOperations.getLastId("menuv1", "menu_id", (error, lastMenuId) => {
    if (error) {
      return res.status(500).send("เกิดข้อผิดพลาดในการดึงค่า MenuId ล่าสุด");
    }

    menuOperations.getLastId(
      "food_categoryv1",
      "category_id",
      (error, lastCateId) => {
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
            lastCateId,
            (error, lastCateId) => {
              if (error) {
                return res
                  .status(500)
                  .send("เกิดข้อผิดพลาดในการแทรกข้อมูลหมวดหมู่");
              }

              menuOperations.insertOption(
                menuData.categories,
                lastMenuId,
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
      }
    );
  });
});

module.exports = router;
