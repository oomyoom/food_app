const { db } = require("../config/database");

async function getDataFromDB(query) {
  return new Promise((resolve, reject) => {
    db.query(query, (error, results) => {
      if (error) {
        reject(error);
        return;
      }
      resolve(results);
    });
  });
}

function getLastId(tableName, columnName, callback) {
  const query = `SELECT MAX(${columnName}) AS maxId FROM \`${tableName}\``;

  db.query(query, (error, results) => {
    if (error) {
      console.error(`เกิดข้อผิดพลาดในการดึงค่า ${columnName} ล่าสุด: `, error);
      callback(error, null);
      return;
    }

    const lastId = results[0].maxId;
    callback(null, lastId + 1 || 1);
  });
}

function updateColumn(query, newValue, callback) {
  db.query(query, newValue, (error, results) => {
    if (error) {
      console.error("เกิดข้อผิดพลาดในการอัปเดตข้อมูล: " + error.message);
      callback(error);
      return;
    } else {
      callback(null, results);
    }
  });
}

module.exports = {
  getDataFromDB,
  getLastId,
  updateColumn,
};
