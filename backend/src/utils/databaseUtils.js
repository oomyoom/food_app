const { db } = require("../config/database");

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

function updateColumn(
  tableName,
  columnName,
  columnQuery,
  newValue,
  idToUpdate,
  callback
) {
  const query = `UPDATE \`${tableName}\` SET ${columnName} = ? WHERE ${columnQuery} = ?`;

  db.query(query, [newValue, idToUpdate], (error, results) => {
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
  getLastId,
  updateColumn,
};
