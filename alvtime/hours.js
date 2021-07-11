#!/usr/bin/env node

const fs = require("fs");
const fetch = require("./fetch");

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

function Tasks() {
  let tasks;
  async function getTasks() {
    const url = process.env.ALVTIME_URL
      ? process.env.ALVTIME_URL
      : "https://api.alvtime.no";
    const path = "/api/user/tasks";
    const options = {
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${process.env.ALVTIME_TOKEN}`,
      },
    };
    const res = await fetch(`${url}${path}`, options);
    tasks = res;
  }

  async function getTaskName(id) {
    if (!tasks) await getTasks();
    return tasks.find((task) => task.id === id);
  }

  return { getTaskName };
}

function Config() {
  let favoriteTasks;
  let token;
  function getConfig() {
    const config = fs.readFileSync("/Users/t/.alvtime", "utf8");
    const lines = config.split("\n");
    const firstLine = lines.shift();
    token = firstLine.split(" ")[0];
    favoriteTasks = lines
      .filter((line) => line.length)
      .map((line) => line.split(" "))
      .map((line) => ({ id: Number(line[0]), name: line[1] }));
  }

  function getToken() {
    if (!token) getConfig();
    return token;
  }

  function getTaskName(id) {
    if (!favoriteTasks) getConfig();
    const task = favoriteTasks.find((task) => task.id === id);
    return task ? task.name : "";
  }

  return { getTaskName, getToken };
}

function TasksNames() {
  const config = Config();
  const tasks = Tasks();

  async function getTaskName(id) {
    const taskName = config.getTaskName(id);
    if (taskName.length > 0) {
      return taskName;
    } else {
      const task = await tasks.getTaskName(id);
      return task ? task.name : "";
    }
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

async function parseHours(data) {
  const { getTaskName } = TasksNames();
  const positiveHours = data.filter((hour) => hour.value);
  const hours = [];
  for (let hour of positiveHours) {
    const { id, weekday } = getWeekday(hour.date);
    const task = (await getTaskName(hour.taskId)).replace(/^\w/, (c) =>
      c.toUpperCase()
    );
    hours.push({
      date: hour.date,
      weekDayId: id,
      weekday,
      task,
      value: hour.value,
    });
  }
  return hours;
}

(async () => {
  const data = await stdin();
  const hours = await parseHours(data);

  let Sum = 0;
  const projects = {};
  const dates = {};
  for (let hour of hours) {
    Sum = Sum + hour.value;
    dates[hour.weekday] = hour.date;

    // Create task rows
    if (!projects[hour.task]) {
      projects[hour.task] = {};
    }
    if (projects[hour.task][hour.weekday]) {
      projects[hour.task][hour.weekday] =
        projects[hour.task][hour.weekday] + hour.value;
    } else {
      projects[hour.task][hour.weekday] = hour.value;
    }

    // Add sum column to task rows
    if (projects[hour.task].Sum) {
      projects[hour.task].Sum = projects[hour.task].Sum + hour.value;
    } else {
      projects[hour.task].Sum = hour.value;
    }
  }

  const table = { Date: dates, ...projects, "---": {}, Sum: { Sum } };
  const headers = [...ukedager, "Sum"];
  console.table(table, headers);
})();
