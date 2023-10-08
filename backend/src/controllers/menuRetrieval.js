const { db } = require("../config/database");

function getMenuFromDB(query) {
  return new Promise((resolve, reject) => {
    db.query(query, (error, results, fields) => {
      if (error) {
        reject(erro0);
        return;
      }
      resolve(results);
    });
  });
}

function getCategoryFromDB(query) {
  return new Promise((resolve, reject) => {
    db.query(query, (error, results, fields) => {
      if (error) {
        reject(error);
        return;
      }
      resolve(results);
    });
  });
}

function getOptionFromDB(query) {
  return new Promise((resolve, reject) => {
    db.query(query, (error, results, fields) => {
      if (error) {
        reject(error);
        return;
      }
      resolve(results);
    });
  });
}

function retrieveMenu(callback) {
  const allMenu = [];

  db.query("SELECT MAX(menu_id) AS maxId FROM menu", async (error, results) => {
    if (error) {
      console.error(`เกิดข้อผิดพลาดในการดึงค่า menu_id ล่าสุด: `, error);
      callback(error, null);
      return;
    }

    const lastId = results[0].maxId;

    for (let i = 0; i < lastId; i++) {
      try {
        const queryMenu = `SELECT * FROM menu WHERE menu_id = ${i + 1}`;
        const menu = await getMenuFromDB(queryMenu);

        if (menu.length > 0) {
          try {
            const queryCategory = `SELECT category_title FROM mcategory WHERE menu_id = ${
              i + 1
            }`;
            const category = await getCategoryFromDB(queryCategory);

            if (category.length > 0) {
              for (let j = 0; j < category.length; j++) {
                try {
                  const queryOption = `SELECT option_title, option_price FROM moption WHERE category_id = ${
                    j + 1
                  }`;
                  const option = await getOptionFromDB(queryOption);

                  if (option.length > 0) {
                    category[j].options = option; // เพิ่มคีย์ options ใน category และกำหนดค่าเป็น option
                  }
                } catch (error) {
                  console.error("เกิดข้อผิดพลาดในการดึงข้อมูล option:", error);
                }
              }
              menu[0].categories = category; // เพิ่มคีย์ categories ใน menu และกำหนดค่าเป็น category
              allMenu.push(menu[0]);
            }
          } catch (error) {
            console.error("เกิดข้อผิดพลาดในการดึงข้อมูล category:", error);
          }
        }
      } catch (error) {
        console.error("เกิดข้อผิดพลาดในการดึงข้อมูล menu:", error);
      }
    }

    // เมื่อเสร็จสิ้นการดึงข้อมูลทั้งหมด เรียก callback เพื่อส่ง allMenu กลับ
    callback(null, allMenu);
  });
}

module.exports = { retrieveMenu };
