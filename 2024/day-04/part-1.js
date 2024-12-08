const fs = require("fs");

const grid = fs.readFileSync("input.txt", "utf8").trim().split("\n");
const word = "XMAS";
const directions = [
  [0, 1],
  [1, 0],
  [1, 1],
  [1, -1],
  [0, -1],
  [-1, 0],
  [-1, -1],
  [-1, 1],
];

let count = 0;

for (let r = 0; r < grid.length; r++) {
  for (let c = 0; c < grid[0].length; c++) {
    count += directions.filter(([dr, dc]) =>
      [...word].every((_, i) => {
        const nr = r + dr * i,
          nc = c + dc * i;
        return grid[nr]?.[nc] === word[i];
      }),
    ).length;
  }
}

console.log(count);
