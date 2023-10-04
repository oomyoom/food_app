//ของร้านอาหาร
const express = require("express");
const router = express.Router();
const { menuData } = require("../models/menu");
const { db } = require("../config/database");

router.post("/menuv2", (req, res) => {
  createMenuv1(menuData);
});

function createMenuv1(menuData) {
  const checkMenuIdQuery = "SELECT MAX(menu_id) AS menu_id FROM menuv1";

  db.query(checkMenuIdQuery, (error, results) => {
    if (error) {
      console.error("เกิดข้อผิดพลาดในการประมวลผลคำสั่ง SQL: ", error);
      return;
    }

    let lastMenuId = results[0].menu_id;

    if (lastMenuId === null) {
      console.log("ไม่มีข้อมูลในตารางหรือ Primary Key ที่มากที่สุด");
      lastMenuId = 1;
    } else {
      lastMenuId++;
      console.log("ค่า MenuId ล่าสุดของ Primary Key คือ: ", lastMenuId);
    }

    const checkCateIdQuery =
      "SELECT MAX(category_id) AS category_id FROM food_categoryv1";

    db.query(checkCateIdQuery, (error, results) => {
      if (error) {
        console.error("เกิดข้อผิดพลาดในการประมวลผลคำสั่ง SQL: ", error);
        return;
      }

      let lastCateId = results[0].category_id;

      if (lastCateId === null) {
        console.log("ไม่มีข้อมูลในตารางหรือ Primary Key ที่มากที่สุด");
        lastCateId = 1;
      } else {
        lastCateId++;
        console.log("ค่า CategoryId ล่าสุดของ Primary Key คือ: ", lastCateId);
      }

      const insertMenu =
        "INSERT INTO menuv1 (menu_title, menu_image, menu_price) VALUES (?, ?, ?)";
      const menuValues = [
        menuData.menu_title,
        menuData.menu_image,
        menuData.menu_price,
      ];

      db.query(insertMenu, menuValues, (error, results) => {
        if (error) {
          console.error("Error inserting data into menu:", error);
        } else {
          console.log("Data inserted into menu:", results);

          const insertFoodCategory =
            "INSERT INTO food_categoryv1 (category_title) VALUES ?";
          const categoryValues = menuData.categories.map((category) => [
            category.category_title,
          ]);

          db.query(insertFoodCategory, [categoryValues], (error, results) => {
            if (error) {
              console.error("Error inserting data into food_category:", error);
              db.end();
            } else {
              console.log("Data inserted into food_category:", results);

              const insertFoodOption =
                "INSERT INTO food_optionv1 (option_title, option_price, menu_id, category_id) VALUES ?";
              const optionValues = menuData.categories.reduce(
                (values, category) => {
                  const categoryOptions = category.options.map((option) => [
                    option.option_title,
                    option.option_price,
                    lastMenuId,
                    lastCateId,
                  ]);
                  lastCateId++;
                  return values.concat(categoryOptions);
                },
                []
              );

              db.query(insertFoodOption, [optionValues], (error, results) => {
                if (error) {
                  console.error(
                    "Error inserting data into food_option:",
                    error
                  );
                  db.end();
                } else {
                  console.log("Data inserted into food_option:", results);
                }
              });
            }
          });
        }
      });
    });
  });
}

module.exports = router;
