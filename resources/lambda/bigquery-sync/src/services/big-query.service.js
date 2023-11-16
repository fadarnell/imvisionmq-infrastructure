const { BigQuery } = require("@google-cloud/bigquery");
const { BIGQUERY_DATASET_ID, SERVICE_ACCOUNT_JSON } = require("../../constants");

const bigQuery = new BigQuery({
  projectId: SERVICE_ACCOUNT_JSON.project_id,
  credentials: {
    ...SERVICE_ACCOUNT_JSON,
  },
});
const datasetId = BIGQUERY_DATASET_ID;

const nowDate = new Date();

const sendData = async (data, tableId) => {
  if (data.length === 0) {
    return;
  }

  data.map( d => d.partition_time = nowDate )

  return bigQuery.dataset(datasetId).table(tableId).insert(data);
};

module.exports = { sendData };
