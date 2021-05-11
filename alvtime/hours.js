#!/usr/bin/env node

const fs = require("fs");

const ukedager = [
  "Mandag",
  "Tirsdag",
  "Onsdag",
  "Torsdag",
  "Fredag",
  "Lørdag",
  "Søndag",
];

function getWeekday(dateStr) {
  const date = new Date(dateStr);
  const id = date.getDay() - 1;
  const weekday = ukedager[id >= 0 ? id : 6];
  return { id, weekday };
}

function Config() {
  const config = fs.readFileSync("/Users/t/.alvtime", "utf8");
  const lines = config.split("\n");
  const favoriteTasks = lines
    .filter((line) => line.length)
    .map((line) => line.split(" "))
    .map((line) => ({ id: Number(line[0]), name: line[1] }));

  function getTaskName(id) {
    const task = favoriteTasks.find((task) => task.id === id);
    return task ? task.name : "";
  }

  return { getTaskName };
}

async function stdin() {
  return new Promise((resolve, reject) => {
    let raw = "";
    const stdin = process.openStdin();
    stdin.on("data", function (chunk) {
      raw += chunk;
    });
    stdin.on("error", reject);
    stdin.on("end", function () {
      const data = JSON.parse(raw);
      resolve(data);
    });
  });
}

function parseHours(data) {
  const { getTaskName } = Config();
  return data
    .filter((hour) => hour.value)
    .map((hour) => {
      const { id, weekday } = getWeekday(hour.date);
      return {
        weekDayId: id,
        weekday,
        task: getTaskName(hour.taskId),
        value: hour.value,
      };
    });
}

(async () => {
  const data = await stdin();
  const hours = parseHours(data);

  let Sum = 0;
  const projects = {};
  for (let hour of hours) {
    Sum = Sum + hour.value;
    if (!projects[hour.task]) {
      projects[hour.task] = {};
    }
    if (projects[hour.task][hour.weekday]) {
      projects[hour.task][hour.weekday] =
        projects[hour.task][hour.weekday] + hour.value;
    } else {
      projects[hour.task][hour.weekday] = hour.value;
    }
    if (projects[hour.task].Sum) {
      projects[hour.task].Sum = projects[hour.task].Sum + hour.value;
    } else {
      projects[hour.task].Sum = hour.value;
    }
  }

  console.table({ ...{ ...projects, "---": {} }, Sum: { Sum } }, [
    ...ukedager,
    "Sum",
  ]);
})();
