const fs = require("fs");

const grid = fs.readFileSync("input.txt", "utf8").trim().split("\n");
const patterns = ["MAS", "SAM"];
let count = 0;

const match = (r, c, dr, dc, p) =>
  p.split("").every((ch, i) => grid[r + dr * i]?.[c + dc * i] === ch);

for (let r = 1; r < grid.length - 1; r++)
  for (let c = 1; c < grid[0].length - 1; c++)
    patterns.forEach((p1) =>
      patterns.forEach(
        (p2) =>
          (count +=
            match(r - 1, c - 1, 1, 1, p1) && match(r - 1, c + 1, 1, -1, p2)),
      ),
    );

console.log(count);
