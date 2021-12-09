const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const print = std.log.info;
const LI = 100;

pub fn main() !void {
    var mat: [LI][]const u8 = undefined;

    var marked: [LI][LI]bool = undefined;
    std.mem.set(bool, @ptrCast(*[LI * LI]bool, &marked), false);

    var basins = std.ArrayList(u8).init(&gpa.allocator);

    var lines_it = std.mem.tokenize(input, "\n");
    var i: u8 = 0;
    while (lines_it.next()) |line| : (i += 1)
        mat[i] = line;

    for (mat) |row, r| {
        for (row) |val, c| {
            const basin: u8 = dfs(r, c, &marked, mat);
            if (basin > 0) try basins.append(basin);
        }
    }
    std.sort.sort(u8, basins.items, {}, comptime std.sort.desc(u8));
    var ans: u32 = basins.items[0];
    ans *= basins.items[1];
    ans *= basins.items[2];
    print("{}", .{ans});
}

fn dfs(i: usize, j: usize, m: *[LI][LI]bool, matrix: [LI][]const u8) u8 {
    if (matrix[i][j] == '9' or m[i][j]) return 0;
    m[i][j] = true;
    const left = if (i > 0) dfs(i - 1, j, m, matrix) else 0;
    const right = if (i < LI - 1) dfs(i + 1, j, m, matrix) else 0;
    const down = if (j > 0) dfs(i, j - 1, m, matrix) else 0;
    const up = if (j < LI - 1) dfs(i, j + 1, m, matrix) else 0;
    return 1 + left + right + down + up;
}
