const { db } = require("../config/database");

function getLastId(tableName, columnName, callback) {
  const query = `SELECT MAX(${columnName}) AS maxId FROM ${tableName}`;

  db.query(query, (error, results) => {
    if (error) {
      console.error(`เกิดข้อผิดพลาดในการดึงค่า ${columnName} ล่าสุด: `, error);
      callback(error, null);
      return;
    }

    const lastId = results[0].maxId;
    callback(null, lastId || 1);
  });
}

function insertMenu(menuData, lastMenuId, callback) {
  const query =
    "INSERT INTO menuv1 (menu_title, menu_image, menu_price) VALUES (?, ?, ?)";
  const values = [
    menuData.menu_title,
    menuData.menu_image,
    menuData.menu_price,
  ];

  db.query(query, values, (error, results) => {
    if (error) {
      console.error("Error inserting data into menu:", error);
      callback(error);
    } else {
      console.log("Data inserted into menu:", results);
      callback(null, lastMenuId);
    }
  });
}

function insertCategory(categoryData, lastCateId, callback) {
  const query = "INSERT INTO food_categoryv1 (category_title) VALUES ?";
  const values = categoryData.map((category) => [category.category_title]);

  db.query(query, [values], (error, results) => {
    if (error) {
      console.error("Error inserting data into food_category:", error);
      callback(error);
    } else {
      console.log("Data inserted into food_category:", results);
      callback(null, lastCateId);
    }
  });
}

function insertOption(categoryData, lastMenuId, lastCateId, callback) {
  const query =
    "INSERT INTO food_optionv1 (option_title, option_price, menu_id, category_id) VALUES ?";
  const values = categoryData.reduce((optionValues, category) => {
    const categoryOptions = category.options.map((option) => [
      option.option_title,
      option.option_price,
      lastMenuId,
      lastCateId,
    ]);
    lastCateId++;
    return optionValues.concat(categoryOptions);
  }, []);

  db.query(query, [values], (error, results) => {
    if (error) {
      console.error("Error inserting data into food_option:", error);
      callback(error);
    } else {
      console.log("Data inserted into food_option:", results);
      callback(null);
    }
  });
}

module.exports = {
  getLastMenuId,
  insertMenu,
  insertCategory,
  insertOption,
};
