const fs = require("fs");

const input = fs.readFileSync("input.txt", "utf8").trim();
let mem = [];

for (let i = 0, label = 0; i < input.length; i++) {
  const repeat = Number(input[i]);
  if (repeat > 0)
    mem.push(...Array(repeat).fill(i % 2 === 0 ? `${label}` : "."));
  if (i % 2 === 0) label++;
}

let end = mem.length;
while (end > 0 && mem[end - 1] === ".") end--;
mem.length = end;

const numBlocks = new Map();
for (let i = mem.length - 1; i >= 0; i--) {
  const num = Number(mem[i]);
  if (!numBlocks.has(num)) {
    let start = i;
    while (start >= 0 && mem[start] === `${num}`) start--;
    numBlocks.set(num, { start: start + 1, length: i - start });
  }
}

for (let num of Array.from(numBlocks.keys()).sort((a, b) => b - a)) {
  const { start, length } = numBlocks.get(num);
  const freeLoc = findFreeBlock(start, length);
  if (freeLoc !== undefined) moveBlock(start, freeLoc, length);
}

console.log(mem.reduce((sum, char, idx) => sum + (Number(char) || 0) * idx, 0));

function findFreeBlock(maxIdx, length) {
  for (let i = 0, freeCount = 0, start = -1; i < maxIdx; i++) {
    if (mem[i] === ".") {
      if (freeCount++ === 0) start = i;
      if (freeCount === length) return start;
    } else {
      freeCount = 0;
    }
  }
}

function moveBlock(from, to, length) {
  mem.copyWithin(to, from, from + length);
  mem.fill(".", from, from + length);
}
