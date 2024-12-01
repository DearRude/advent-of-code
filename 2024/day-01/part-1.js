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

first = first.sort();
second = second.sort();

let ans = 0;
for (let i = 0; i < first.length; i++) {
  ans += Math.abs(first[i] - second[i]);
}

console.log(ans);
