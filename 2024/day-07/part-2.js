const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split(":"));

console.log(input.reduce((count, line) => count + isValid(line), 0));

function isValid([target, numsStr]) {
  const nums = numsStr.trim().split(" ").map(Number);
  target = Number(target);

  return generateCombinations(nums.length - 1).some((combo) => {
    let sum = nums[0];
    for (let i = 0; i < combo.length; i++) {
      sum =
        combo[i] === 2
          ? sum * nums[i + 1]
          : combo[i] === 1
            ? sum + nums[i + 1]
            : Number(`${sum}${nums[i + 1]}`);
    }
    return sum === target;
  })
    ? target
    : 0;
}

function generateCombinations(n) {
  return Array.from({ length: Math.pow(3, n) }, (_, i) =>
    i.toString(3).padStart(n, "0").split("").map(Number),
  );
}
