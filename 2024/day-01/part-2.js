const fs = require("fs");

const data = fs.readFileSync("input.txt", "utf8");
const lines = data.split("\n");

let first = [];
let second = [];

lines.forEach((line) => {
  let nums = line.split("   ");
  first.push(Number(nums[0]));
  second.push(Number(nums[1]));
});

const counter = new Map();
second.forEach((ele) => {
  counter.set(ele, (counter.get(ele) ?? 0) + 1);
});

let total = 0;
first.forEach((ele) => {
  total += (counter.get(ele) ?? 0) * ele;
});

console.log(total);
