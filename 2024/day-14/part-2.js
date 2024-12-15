const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.match(/[-+]?\d+/g).map(Number));

// const [ROWS, COLS] = [7, 11];
const [ROWS, COLS] = [103, 101];

let scores = [];
for (let iter = 0; iter < 10 ** 4; iter++) {
  const grid = Array.from({ length: ROWS }, () => Array(COLS).fill(false));
  for (let i = 0; i < input.length; i++) {
    const [x, y] = nextSecond(input[i], iter);
    grid[x][y] = true;
  }
  scores.push([iter, randomnessScore(grid)]);
}
scores.sort((a, b) => a[1] - b[1]);
console.log(scores[0][0]);

function nextSecond([x, y, xVol, yVol], step) {
  return [wrap(x + step * xVol, COLS), wrap(y + step * yVol, ROWS)];
}

function wrap(a, b) {
  return ((a % b) + b) % b;
}

function randomnessScore(grid) {
  let differingPairs = 0;
  let totalPairs = 0;

  for (let r = 0; r < ROWS; r++) {
    for (let c = 0; c < COLS; c++) {
      if (c + 1 < COLS) {
        totalPairs++;
        if (grid[r][c] !== grid[r][c + 1]) differingPairs++;
      }
      if (r + 1 < ROWS) {
        totalPairs++;
        if (grid[r][c] !== grid[r + 1][c]) differingPairs++;
      }
    }
  }

  return totalPairs === 0 ? 0 : differingPairs / totalPairs;
}
