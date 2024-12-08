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
  if (isValidSequence(numbers)) {
    return total;
  }

  while (!isValidSequence(numbers)) {
    for (let i = 0; i < numbers.length - 1; i++) {
      if (!(ruleMap[numbers[i]] || []).includes(numbers[i + 1])) {
        [numbers[i], numbers[i + 1]] = [numbers[i + 1], numbers[i]];
        break;
      }
    }
  }

  return total + Number(numbers[Math.floor(numbers.length / 2)]);
}, 0);

console.log(sum);

function isValidSequence(numbers) {
  return numbers.every(
    (num, i) =>
      i === numbers.length - 1 || (ruleMap[num] || []).includes(numbers[i + 1]),
  );
}
