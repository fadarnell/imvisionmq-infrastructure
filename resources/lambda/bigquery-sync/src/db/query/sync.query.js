const { query } = require("../db");

const getLastSyncQuery = async () => {
  const rowDb = await query(`
    SELECT last_sync
    FROM public.big_query_date_sync
    ORDER BY last_sync DESC
    LIMIT 1
  `);
  return rowDb.length > 0 ? rowDb[0].last_sync : null;
};

const updateLastSyncDateQuery = async (initialDate) => {
  return query(`
    UPDATE public.big_query_date_sync
    SET last_sync = $1
  `, [initialDate.toISOString()]);
};

const insertLastSyncDateQuery = async (initialDate) => {
  return query(`
    INSERT INTO public.big_query_date_sync
    (last_sync)
    VALUES ($1);
  `, [initialDate.toISOString()]);
};

module.exports = {
  getLastSyncQuery,
  updateLastSyncDateQuery,
  insertLastSyncDateQuery,
};