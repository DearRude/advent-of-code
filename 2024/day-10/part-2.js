const fs = require("fs");

const grid = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split("").map(Number));

const countPaths = (grid, start, end) => {
  const dims = grid.length;
  let count = 0;

  const dfs = (x, y, path, prevValue) => {
    if (
      x < 0 ||
      y < 0 ||
      x >= dims ||
      y >= dims ||
      path.includes(`${x},${y}`) ||
      grid[x][y] !== prevValue + 1
    )
      return;

    path.push(`${x},${y}`);

    const [startX, startY] = path[0].split(",").map(Number);
    if (
      grid[x][y] === end &&
      path.length > 1 &&
      grid[startX][startY] === start
    ) {
      count++;
    } else {
      [
        [0, 1],
        [1, 0],
        [0, -1],
        [-1, 0],
      ].forEach(([dx, dy]) => dfs(x + dx, y + dy, path, grid[x][y]));
    }

    path.pop();
  };

  grid.forEach((row, i) =>
    row.forEach((value, j) => {
      if (value === start) dfs(i, j, [], start - 1);
    }),
  );

  return count;
};

console.log(countPaths(grid, 0, 9));
