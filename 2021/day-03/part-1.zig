const std = @import("std");
const input = @embedFile("input.txt");

pub fn main() !void {
    var lines = std.mem.tokenize(input, "\n");

    var li = lines;
    const count_column: u32 = @intCast(u32, li.next().?.len);
    var count_line: u32 = 1;
    while (li.next()) |_| : (count_line += 1) {}

    var gamma_rate: u32 = 0;
    var idx: u32 = 0;
    while (idx < count_column) : (idx += 1) {
        li = lines;
        var count_zero: u32 = 0;
        while (li.next()) |binary| {
            if (binary[idx] == '0')
                count_zero += 1;
        }
        if (count_zero < count_line / 2)
            gamma_rate |= @as(u16, 1) << @intCast(u4, count_column - idx - 1);
    }
    const pad: u32 = 32 - @intCast(u32, count_column);
    const epsilon_rate = std.math.pow(u32, 2, count_column) - 1 - gamma_rate;
    std.log.info("{}", .{gamma_rate * epsilon_rate});
}
