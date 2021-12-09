const std = @import("std");
const input = @embedFile("input.txt");
const print = std.log.info;
const LI = 100;

pub fn main() !void {
    var ans: u32 = 0;
    var mat: [LI][]const u8 = undefined;

    var lines_it = std.mem.tokenize(input, "\n");
    var i: u8 = 0;
    while (lines_it.next()) |line| : (i += 1)
        mat[i] = line;

    for (mat) |row, r| {
        for (row) |val, c| {
            if (c > 0 and mat[r][c] >= mat[r][c - 1]) continue;
            if (c < LI - 1 and mat[r][c] >= mat[r][c + 1]) continue;
            if (r > 0 and mat[r][c] >= mat[r - 1][c]) continue;
            if (r < Li - 1 and mat[r][c] >= mat[r + 1][c]) continue;
            ans += val - '0' + 1;
        }
    }
    print("{}", .{ans});
}
