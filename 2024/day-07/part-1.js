const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split(":"));

console.log(input.reduce((count, line) => count + isValid(line), 0));

function isValid([target, numsStr]) {
  const nums = numsStr.trim().split(" ").map(Number);
  return generateCombinations(nums.length - 1).some((combo) => {
    const sum = combo.reduce(
      (acc, op, idx) => (op ? acc * nums[idx + 1] : acc + nums[idx + 1]),
      nums[0],
    );
    return sum == target;
  })
    ? Number(target)
    : 0;
}

function generateCombinations(n) {
  return Array.from({ length: 1 << n }, (_, i) =>
    i.toString(2).padStart(n, "0").split("").map(Number),
  );
}
