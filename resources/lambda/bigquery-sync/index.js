const { sync } = require("./src/handler.js");

async function handler() {
  return sync();
}

module.exports = { handler };