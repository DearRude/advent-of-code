const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n\n")
  .map((chunk) => chunk.match(/\d+/g).map(Number));

let total = input.reduce((sum, chunk) => {
  let tokens = Infinity;

  for (let a = 0; a <= 100; a++) {
    for (let b = 0; b <= 100; b++) {
      if (
        a * chunk[0] + b * chunk[2] === chunk[4] &&
        a * chunk[1] + b * chunk[3] === chunk[5]
      ) {
        tokens = Math.min(tokens, a * 3 + b);
      }
    }
  }

  return tokens === Infinity ? sum : sum + tokens;
}, 0);

console.log(total);
