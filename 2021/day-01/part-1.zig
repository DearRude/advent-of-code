const std = @import("std");

const input = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.tokenize(input, "\n");
    var nums = std.ArrayList(u32).init(std.testing.allocator);
    defer nums.deinit();
    while (lines.next()) |line| {
        try nums.append(try std.fmt.parseInt(u32, line, 10));
    }
    var increases: u32 = 0;
    var i: u32 = 1;
    while (i < nums.items.len) : (i += 1) {
        if (nums.items[i - 1] < nums.items[i]) {
            increases += 1;
        }
    }

    std.debug.print("{}\n", .{increases});
}
