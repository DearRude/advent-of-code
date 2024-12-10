const fs = require("fs");

const input = fs.readFileSync("input.txt", "utf8").trim().split("");

let mem = new Array();
input.forEach((char, idx) => {
  let ch = idx % 2 ? "." : `${idx / 2}`;
  for (let i = 0; i < Number(char); i++) {
    mem.push(ch);
  }
});

mem.forEach((char, idx) => {
  while (mem[mem.length - 1] === ".") {
    mem.pop();
  }
  if (char === ".") {
    mem[idx] = mem.pop();
  }
});

console.log(mem.reduce((sum, char, idx) => sum + Number(char) * idx, 0));
