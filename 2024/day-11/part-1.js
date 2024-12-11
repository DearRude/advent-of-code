const fs = require("fs");

const input = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split(" ")
  .map(Number);

function convolute(input) {
  let output = [];
  for (let num of input) {
    if (num === 0) output.push(1);
    else if (String(num).length % 2 === 0) {
      const numStr = num.toString();
      const mid = numStr.length / 2;
      output.push(Number(numStr.slice(0, mid)));
      output.push(Number(numStr.slice(mid)));
    } else output.push(num * 2024);
  }

  return output;
}

let result = input;

for (let i = 0; i < 25; i++) {
  result = convolute(result);
}

console.log(result.length);
