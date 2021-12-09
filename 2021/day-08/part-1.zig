const std = @import("std");
const input = @embedFile("input.txt");
const print = std.log.info;

pub fn main() !void {
    var ans: u16 = 0;
    var lines_it = std.mem.tokenize(input, "\n,");
    while (lines_it.next()) |line| {
        var part_it = std.mem.tokenize(line, "|");
        var tmp = part_it.next().?;
        var nums_it = std.mem.tokenize(part_it.next().?, " ");
        while (nums_it.next()) |num| {
            ans += switch (num.len) {
                2, 3, 4, 7 => 1,
                else => @intCast(u8, 0),
            };
        }
    }
    print("{}", .{ans});
}
