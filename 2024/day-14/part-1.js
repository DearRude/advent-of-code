const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.match(/[-+]?\d+/g).map(Number));

// const [ROWS, COLS] = [7, 11];
const [ROWS, COLS] = [103, 101];

let counts = [0, 0, 0, 0];
for (let i = 0; i < input.length; i++) {
  const place = whereIsRobot(nextSecond(input[i], 100));
  if (place !== -1) counts[place]++;
}

console.log(counts.reduce((acc, curr) => acc * curr, 1));

function whereIsRobot([x, y]) {
  let res = 0b00;
  if (y == (ROWS - 1) / 2 || x == (COLS - 1) / 2) return -1;
  if (y < (ROWS - 1) / 2) res |= 0b01;
  if (x < (COLS - 1) / 2) res |= 0b10;
  return res;
}

function nextSecond([x, y, xVol, yVol], step) {
  return [wrap(x + step * xVol, COLS), wrap(y + step * yVol, ROWS)];
}

function wrap(a, b) {
  return ((a % b) + b) % b;
}
