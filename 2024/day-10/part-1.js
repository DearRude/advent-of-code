const fs = require("fs");

const grid = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split("").map(Number));

const countPaths = (grid, start, end) => {
  const dims = grid.length;
  const uniquePaths = new Set();

  const dfs = (x, y, prevValue, startPos, endPos) => {
    if (
      x < 0 ||
      y < 0 ||
      x >= dims ||
      y >= dims ||
      grid[x][y] !== prevValue + 1
    )
      return;

    const position = `${x},${y}`;
    if (grid[x][y] === start) startPos = position;
    if (grid[x][y] === end) return uniquePaths.add(`${startPos}->${position}`);

    const temp = grid[x][y];
    grid[x][y] = -1; // Mark as visited

    [
      [0, 1],
      [1, 0],
      [0, -1],
      [-1, 0],
    ].forEach(([dx, dy]) => dfs(x + dx, y + dy, temp, startPos, position));

    grid[x][y] = temp; // Unmark
  };

  grid.forEach((row, i) =>
    row.forEach((value, j) => {
      if (value === start) dfs(i, j, start - 1, null, null);
    }),
  );

  return uniquePaths.size;
};

console.log(countPaths(grid, 0, 9));
