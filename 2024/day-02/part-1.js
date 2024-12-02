const fs = require("fs");

const data = fs.readFileSync("input.txt", "utf8");
const lines = data.trim().split("\n");

let safeCount = 0;
lines.forEach((line) => {
  const nums = line.split(" ").map(Number);
  const isIncreasing = nums[1] - nums[0] > 0;

  for (let i = 0; i < nums.length - 1; i++) {
    diff = nums[i + 1] - nums[i];
    if (isIncreasing != diff > 0 || diff == 0 || Math.abs(diff) > 3) {
      return;
    }
  }
  safeCount++;
});

console.log(safeCount);
