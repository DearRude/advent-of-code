const fs = require("fs");

const [rules, updates] = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n\n");

const ruleMap = rules.split("\n").reduce((map, line) => {
  const [key, value] = line.split("|");
  (map[key] ||= []).push(value);
  return map;
}, {});

const sum = updates.split("\n").reduce((total, update) => {
  const numbers = update.split(",");
  const isValid = numbers.every(
    (num, i) =>
      i === numbers.length - 1 || (ruleMap[num] || []).includes(numbers[i + 1]),
  );
  return isValid
    ? total + Number(numbers[Math.floor(numbers.length / 2)])
    : total;
}, 0);

console.log(sum);
