const { db } = require("../config/database");
const databaseUtils = require("../utils/databaseUtils");

async function retrieveMenu() {
  const allMenu = [];

  try {
    const maxIdQuery = "SELECT MAX(menu_id) AS maxId FROM menu";
    const [maxIdResult] = await databaseUtils.getDataFromDB(maxIdQuery);
    const lastId = maxIdResult.maxId;

    for (let i = 0; i < lastId; i++) {
      const menuQuery = `SELECT * FROM menu WHERE menu_id = ${i + 1}`;
      const menuResults = await databaseUtils.getDataFromDB(menuQuery);

      if (menuResults.length > 0) {
        const categoryIdQuery = `SELECT category_title FROM mcategory WHERE menu_id = ${
          i + 1
        }`;
        const categoryResults = await databaseUtils.getDataFromDB(
          categoryIdQuery
        );

        if (categoryResults.length > 0) {
          for (let j = 0; j < categoryResults.length; j++) {
            const optionQuery = `SELECT option_title, option_price FROM moption WHERE category_id = ${
              j + 1
            }`;
            const optionResults = await databaseUtils.getDataFromDB(
              optionQuery
            );

            if (optionResults.length > 0) {
              categoryResults[j].options = optionResults;
            }
          }

          menuResults[0].categories = categoryResults;
          allMenu.push(menuResults[0]);
        }
      }
    }

    return allMenu;
  } catch (error) {
    throw error;
  }
}

module.exports = { retrieveMenu };
