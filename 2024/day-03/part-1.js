const fs = require("fs");

const data = fs.readFileSync("input.txt", "utf8").trim();

const regex = /mul\((\d{1,3}),(\d{1,3})\)/g;

const sum = Array.from(data.matchAll(regex)).reduce(
  (total, [, x, y]) => total + x * y,
  0,
);

console.log(sum);
