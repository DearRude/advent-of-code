const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n\n")
  .map((chunk) => chunk.match(/\d+/g).map(Number));

// Solve for a and b using Cramer's rule
function solveChunk([aX, aY, bX, bY, prizeX, prizeY]) {
  const det = aX * bY - bX * aY;

  const aNum = prizeX * bY - bX * prizeY;
  const bNum = aX * prizeY - prizeX * aY;

  if (aNum % det !== 0 || bNum % det !== 0) {
    return 0;
  }

  return 3 * (aNum / det) + bNum / det;
}

let total = input.reduce((sum, chunk) => {
  chunk[4] += 10 ** 13;
  chunk[5] += 10 ** 13;
  return sum + solveChunk(chunk);
}, 0);

console.log(total);
