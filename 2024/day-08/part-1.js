const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split(""));

const antennaMap = new Map();
input.forEach((line, row) =>
  line.forEach((char, col) => {
    if (char !== ".") {
      antennaMap.set(char, [...(antennaMap.get(char) || []), [row, col]]);
    }
  }),
);

const antinodes = input.map((row) => Array(row.length).fill(false));

antennaMap.forEach((positions) => {
  positions.forEach(([x1, y1], i) => {
    positions.slice(i + 1).forEach(([x2, y2]) => {
      [
        [x1 + (x1 - x2), y1 + (y1 - y2)],
        [x2 + (x2 - x1), y2 + (y2 - y1)],
      ].forEach(([x, y]) => {
        if (
          x >= 0 &&
          x < antinodes.length &&
          y >= 0 &&
          y < antinodes[0].length
        ) {
          antinodes[x][y] = true;
        }
      });
    });
  });
});

console.log(antinodes.flat().filter(Boolean).length);
