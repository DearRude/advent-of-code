const fs = require("fs");

const lines = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split(" ").map(Number));

let safeCount = 0;

lines.forEach((nums) => {
  if (nums.some((_, i) => checkLine(nums.filter((_, index) => index !== i)))) {
    safeCount++;
  }
});

function checkLine(nums) {
  const isIncreasing = nums[1] > nums[0];

  return nums.slice(1).every((num, i) => {
    const diff = num - nums[i];
    return isIncreasing === diff > 0 && diff !== 0 && Math.abs(diff) <= 3;
  });
}

console.log(safeCount);
