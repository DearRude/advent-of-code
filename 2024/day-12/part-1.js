const fs = require("fs");

const grid = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((line) => line.split(""));

const n = grid.length;
const visited = Array.from({ length: n }, () => Array(n).fill(false));
const directions = [
  [0, 1],
  [1, 0],
  [0, -1],
  [-1, 0],
];
let totalSum = 0;

const dfs = (x, y, char) => {
  let area = 0,
    perimeter = 0,
    stack = [[x, y]];
  visited[x][y] = true;

  while (stack.length) {
    const [cx, cy] = stack.pop();
    area++;
    for (const [dx, dy] of directions) {
      const nx = cx + dx,
        ny = cy + dy;
      if (nx >= 0 && ny >= 0 && nx < n && ny < n) {
        if (grid[nx][ny] === char && !visited[nx][ny]) {
          visited[nx][ny] = true;
          stack.push([nx, ny]);
        } else if (grid[nx][ny] !== char) perimeter++;
      } else perimeter++;
    }
  }
  return area * perimeter;
};

for (let i = 0; i < n; i++) {
  for (let j = 0; j < n; j++) {
    if (!visited[i][j]) totalSum += dfs(i, j, grid[i][j]);
  }
}

console.log(totalSum);
