const fs = require("fs");

let stateCounts = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split(" ")
  .map(Number)
  .reduce((map, num) => {
    map.set(num, (map.get(num) || 0) + 1);
    return map;
  }, new Map());

function convoluteCounts(stateCounts) {
  const newStateCounts = new Map();

  for (const [num, count] of stateCounts) {
    if (num === 0) {
      newStateCounts.set(1, (newStateCounts.get(1) || 0) + count);
    } else {
      const len = Math.floor(Math.log10(num)) + 1;
      if (len % 2 === 0) {
        const mid = Math.pow(10, len / 2);
        const left = Math.floor(num / mid);
        const right = num % mid;
        newStateCounts.set(left, (newStateCounts.get(left) || 0) + count);
        newStateCounts.set(right, (newStateCounts.get(right) || 0) + count);
      } else {
        const transformed = num * 2024;
        newStateCounts.set(
          transformed,
          (newStateCounts.get(transformed) || 0) + count,
        );
      }
    }
  }

  return newStateCounts;
}

for (let i = 0; i < 75; i++) {
  stateCounts = convoluteCounts(stateCounts);
}

const totalNumbers = [...stateCounts.values()].reduce(
  (sum, count) => sum + count,
  0,
);
console.log(totalNumbers);
