require("dotenv").config();
const { sendData } = require("./services/big-query.service");
const {
  getUsers,
  getOrganizations,
  getPractices,
  getCaseCards,
  getCaseCardWorkflowTransitionLog,

  getLastSyncQuery,
  insertLastSyncDateQuery,
  updateLastSyncDateQuery,

  getRoles,
  getUsersRoles,

  getTenantCaseCardsLinks,
  getTenantPatientsLinks,
  getTenantRolesLinks,
  getTenantUsersLinks,
} = require("./services/database.service");
const {
  BIGQUERY_TABLE_USERS_ID,
  BIGQUERY_TABLE_ORGANIZATIONS_ID,
  BIGQUERY_TABLE_PRACTICES_ID,
  BIGQUERY_TABLE_CASE_CARDS_ID,

  BIGQUERY_TABLE_USER_ROLES_ID,
  BIGQUERY_TABLE_ROLES_ID,

  BIGQUERY_TABLE_PATIENTS_LINK_ID,
  BIGQUERY_TABLE_CASE_CARD_LINK_ID,
  BIGQUERY_TABLE_ROLE_LINK_ID,
  BIGQUERY_TABLE_USER_LINK_ID,
  BIGQUERY_TABLE_CASE_CARDS_TRANS_LOG_ID,
} = require("../constants");

const Getters = [
  { getter: getUsers, tableId: BIGQUERY_TABLE_USERS_ID },
  { getter: getOrganizations, tableId: BIGQUERY_TABLE_ORGANIZATIONS_ID },
  { getter: getPractices, tableId: BIGQUERY_TABLE_PRACTICES_ID },
  { getter: getCaseCards, tableId: BIGQUERY_TABLE_CASE_CARDS_ID },
  { getter: getCaseCardWorkflowTransitionLog, tableId: BIGQUERY_TABLE_CASE_CARDS_TRANS_LOG_ID },

  { getter: getRoles, tableId: BIGQUERY_TABLE_ROLES_ID },
  { getter: getUsersRoles, tableId: BIGQUERY_TABLE_USER_ROLES_ID },

  { getter: getTenantUsersLinks, tableId: BIGQUERY_TABLE_USER_LINK_ID },
  { getter: getTenantRolesLinks, tableId: BIGQUERY_TABLE_ROLE_LINK_ID },
  { getter: getTenantPatientsLinks, tableId: BIGQUERY_TABLE_PATIENTS_LINK_ID },
  { getter: getTenantCaseCardsLinks, tableId: BIGQUERY_TABLE_CASE_CARD_LINK_ID },
];

const sync = async () => {
  try {
    // let lastSync = await getLastSyncQuery();
    // if (!lastSync) {
    //   await insertLastSyncDateQuery(lastSync);
    // }
    // const lastDataSynced = lastSync;

    for (const { getter, tableId } of Getters) {
      const res = await getter("1970-01-01");
      const resChunks = chunkArray(res, 100);

      for (const chunk of resChunks) {
        try {
          await sendData(chunk, tableId);
        } catch(e) {
          console.error(e.message);
          console.error(JSON.stringify(e.errors))
        }
      }
    }

    // await updateLastSyncDateQuery(new Date());

    return {
      statusCode: 200,
    };
  } catch (err) {
    console.log(err);

    return {
      statusCode: 400,
      code: err.code,
      message: err.message,
    };
  }
};

function chunkArray(array, chunkSize) {
  if (chunkSize <= 0) throw new Error("Chunk size must be greater than 0");

  let result = [];
  for (let i = 0; i < array.length; i += chunkSize) {
      result.push(array.slice(i, i + chunkSize));
  }
  return result;
}

module.exports = { sync };