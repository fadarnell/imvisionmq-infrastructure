const { Pool } = require("pg");
const { DEBUG } = require("../../constants");

const pool = new Pool({
  connectionString: process.env.PG_URI,
});

const query = async (text, params) => {
  const start = Date.now();
  const result = await pool.query(text, params);
  const duration = Date.now() - start;
  if (DEBUG) {
    console.log('executed query', { text, duration, rows: result.rowCount, params });
  }
  return result.rows;
};

module.exports = { query };