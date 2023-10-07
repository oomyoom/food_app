const { db } = require("../config/database");

function insertMenu(menuData, lastMenuId, callback) {
  const query =
    "INSERT INTO menu (menu_title, menu_image, menu_price) VALUES (?, ?, ?)";
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
  const query = "INSERT INTO mcategory (category_title) VALUES ?";
  const values = categoryData.map((category) => [category.category_title]);

  db.query(query, [values], (error, results) => {
    if (error) {
      console.error("Error inserting data into mcategory:", error);
      callback(error);
    } else {
      console.log("Data inserted into mcategory:", results);
      callback(null, lastCateId);
    }
  });
}

function insertOption(categoryData, lastMenuId, lastCateId, callback) {
  const query =
    "INSERT INTO moption (option_title, option_price, menu_id, category_id) VALUES ?";
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
      console.error("Error inserting data into moption:", error);
      callback(error);
    } else {
      console.log("Data inserted into moption:", results);
      callback(null);
    }
  });
}

module.exports = {
  insertMenu,
  insertCategory,
  insertOption,
};
