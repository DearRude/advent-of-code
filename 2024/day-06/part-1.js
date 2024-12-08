const fs = require("fs");

const grid = fs.readFileSync("input.txt", "utf8").trim().split("\n");
const directions = [
  [-1, 0],
  [0, 1],
  [1, 0],
  [0, -1],
];
const viewed = grid.map((row) => Array(row.length).fill(false));

let [x, y] = (() => {
  for (let i = 0; i < grid.length; i++) {
    const col = grid[i].indexOf("^");
    if (col !== -1) return [i, col];
  }
})();

let currDir = 0;
while (x >= 0 && x < grid.length && y >= 0 && y < grid[0].length) {
  if (grid[x][y] === "#") {
    [x, y] = [x - directions[currDir][0], y - directions[currDir][1]];
    currDir = (currDir + 1) % 4;
  } else {
    viewed[x][y] = true;
    [x, y] = [x + directions[currDir][0], y + directions[currDir][1]];
  }
}

console.log(viewed.flat().filter(Boolean).length);
