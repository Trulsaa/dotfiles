const https = require("https");

function fetch(url, options) {
  return new Promise((resolve, reject) => {
    https
      .get(url, options, (response) => {
        let chunks = "";
        response.on("data", (chunk) => {
          chunks += chunk;
        });
        response.on("end", () => {
          resolve(JSON.parse(chunks));
        });
      })
      .on("error", (error) => {
        reject("Error: " + error.message);
      });
  });
}

module.exports = fetch;
