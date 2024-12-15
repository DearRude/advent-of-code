const fs = require("fs");

const [gridStr, cmdStr] = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n\n");
const commands = cmdStr.replace(/\n/g, "").split("");
let grid = gridStr.split("\n").map((row) => row.split(""));

let robot = grid
  .flatMap((row, y) => row.map((cell, x) => (cell === "@" ? { x, y } : null)))
  .find((pos) => pos);

const directions = { "<": [-1, 0], ">": [1, 0], "^": [0, -1], v: [0, 1] };

const move = (dir) => {
  const [dx, dy] = directions[dir];
  let { x, y } = robot;
  let newX = x + dx,
    newY = y + dy;

  const target = grid[newY][newX];
  if (target === ".") {
    [grid[y][x], grid[newY][newX]] = [".", "@"];
    robot = { x: newX, y: newY };
  } else if (target === "O") {
    let boxes = [];
    let cx = newX,
      cy = newY;
    while (grid[cy]?.[cx] === "O") {
      boxes.push({ x: cx, y: cy });
      cx += dx;
      cy += dy;
    }
    if (grid[cy]?.[cx] === ".") {
      boxes.reverse().forEach((box) => {
        grid[box.y][box.x] = ".";
        grid[box.y + dy][box.x + dx] = "O";
      });
      [grid[y][x], grid[newY][newX]] = [".", "@"];
      robot = { x: newX, y: newY };
    }
  }
};

commands.forEach(move);

const sumGps = grid.flat().reduce((sum, cell, idx) => {
  if (cell === "O") {
    const y = Math.floor(idx / grid[0].length);
    const x = idx % grid[0].length;
    return sum + 100 * y + x;
  }
  return sum;
}, 0);

console.log(sumGps);
