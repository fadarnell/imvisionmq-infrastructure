const dataQuery = require("../db/query/data.query.js");
const syncQuery = require("../db/query/sync.query.js");

module.exports = {
  ...dataQuery,
  ...syncQuery
};