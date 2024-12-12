const fs = require("fs");

const map = fs
  .readFileSync("input.txt", "utf8")
  .trim()
  .split("\n")
  .map((l) => l.split(""));
const rows = map.length,
  cols = map[0].length;
const DIRS = [
  [0, -1],
  [1, 0],
  [0, 1],
  [-1, 0],
];
const FENCES_STARTS = [
  [0, 0],
  [1, 0],
  [1, 1],
  [0, 1],
];
const FENCES_ENDS = [
  [1, 0],
  [1, 1],
  [0, 1],
  [0, 0],
];
const offMap = (x, y) => x < 0 || y < 0 || x >= cols || y >= rows;

let checked = map.map((r) => r.map(() => 0)),
  res = 0;

const floodfill = (sx, sy) => {
  let region = map.map((r) => r.map(() => 0)),
    stack = [[sx, sy]],
    v = map[sy][sx];
  while (stack.length) {
    let [x, y] = stack.pop();
    if (region[y][x]) continue;
    region[y][x] = 1;
    for (let [dx, dy] of DIRS) {
      let nx = x + dx,
        ny = y + dy;
      if (offMap(nx, ny) || region[ny][nx] || map[ny][nx] != v) continue;
      stack.push([nx, ny]);
    }
  }
  return region;
};

for (let y = 0; y < rows; y++) {
  for (let x = 0; x < cols; x++) {
    if (checked[y][x]) continue;
    let region = floodfill(x, y),
      area = 0,
      fences = [];
    for (let ry = 0; ry < rows; ry++) {
      for (let rx = 0; rx < cols; rx++) {
        if (!region[ry][rx]) continue;
        checked[ry][rx] = 1;
        area++;
        DIRS.forEach(([dx, dy], d) => {
          let nx = rx + dx,
            ny = ry + dy;
          if (offMap(nx, ny) || region[ny]?.[nx] != 1) {
            fences.push([
              [rx + FENCES_STARTS[d][0], ry + FENCES_STARTS[d][1]],
              [rx + FENCES_ENDS[d][0], ry + FENCES_ENDS[d][1]],
            ]);
          }
        });
      }
    }
    let segments = [];
    fences.forEach((f) => {
      let df = [f[1][0] - f[0][0], f[1][1] - f[0][1]],
        found = false;
      segments.some((seg, si) => {
        return seg.some((s) => {
          let ds = [s[1][0] - s[0][0], s[1][1] - s[0][1]];
          if (
            ds[0] == df[0] &&
            ds[1] == df[1] &&
            ((s[0][0] == f[1][0] && s[0][1] == f[1][1]) ||
              (s[1][0] == f[0][0] && s[1][1] == f[0][1]))
          ) {
            found = si;
            return true;
          }
        });
      });
      found !== false ? segments[found].push(f) : segments.push([f]);
    });
    res += area * segments.length;
  }
}

console.log(res);
