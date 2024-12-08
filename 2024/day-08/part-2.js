const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split(""));

const antennaMap = new Map();
input.forEach((row, r) =>
  row.forEach((char, c) => {
    if (char !== ".")
      (antennaMap.get(char) || antennaMap.set(char, []).get(char)).push([r, c]);
  }),
);

const antinodes = Array.from({ length: input.length }, () =>
  Array(input.length).fill(false),
);

antennaMap.forEach((pairs) => {
  pairs.forEach(([r1, c1], i) => {
    pairs.slice(i + 1).forEach(([r2, c2]) => {
      addAntiNodes(r1, c1, r2, c2);
    });
  });
});

console.log(antinodes.flat().filter(Boolean).length);

function addAntiNodes(r1, c1, r2, c2) {
  const directions = [
    [r1 - r2, c1 - c2],
    [r2 - r1, c2 - c1],
  ];
  directions.forEach(([dr, dc]) => {
    let r = r1,
      c = c1;
    while (r >= 0 && r < antinodes.length && c >= 0 && c < antinodes.length) {
      antinodes[r][c] = true;
      r += dr;
      c += dc;
    }
  });
}
