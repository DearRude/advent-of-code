const std = @import("std");
const input = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.tokenize(input, "\n");
    var forward: u32 = 0;
    var depth: u32 = 0;
    var aim: u32 = 0;
    while (lines.next()) |line| {
        var dirValue = std.mem.tokenize(line, " ");
        const dir = dirValue.next().?;
        const value = try std.fmt.parseInt(u32, dirValue.next().?, 10);
        if (std.mem.eql(u8, dir, "down")) {
            aim += value;
        } else if (std.mem.eql(u8, dir, "up")) {
            aim -= value;
        } else {
            forward += value;
            depth += aim * value;
        }
    }
    std.log.info("{}", .{forward * depth});
}
