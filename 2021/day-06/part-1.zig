const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const print = std.log.info;

pub fn main() !void {
    var counts: [9]u41 = undefined;
    std.mem.set(u41, &counts, 0);

    var nums_it = std.mem.tokenize(input, ",");
    while (nums_it.next()) |num|
        counts[try std.fmt.parseInt(u8, num, 10)] += 1;

    var it: u16 = 0;
    while (it < 80) : (it += 1) {
        const pregnants = counts[0];
        var idx: u8 = 1;
        while (idx < 9) : (idx += 1)
            counts[idx - 1] = counts[idx];
        counts[6] += pregnants;
        counts[8] = pregnants;
    }

    var sum: u45 = 1;
    for (counts) |val|
        sum += val;
    print("{}", .{sum});
}
