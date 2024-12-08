const fs = require("fs");

const data = fs.readFileSync("input.txt", "utf8").trim();

const regex = /(do\(\)|don't\(\)|mul\((\d{1,3}),(\d{1,3})\))/g;

let enabled = true,
  sum = 0;

Array.from(data.matchAll(regex)).forEach(([instruction, , x, y]) => {
  if (instruction === "do()") enabled = true;
  else if (instruction === "don't()") enabled = false;
  else if (enabled && x && y) sum += x * y;
});

console.log(sum);
