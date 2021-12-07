const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const print = std.log.info;

// This question also can be solved with calculating the median
// but this solution is fast enough (I guess?)

pub fn main() !void {
    var nums_it = std.mem.tokenize(input, "\n,");
    var nums = std.ArrayList(i16).init(&gpa.allocator);
    while (nums_it.next()) |num|
        try nums.append(try std.fmt.parseUnsigned(i16, num, 10));

    var min_sum: i32 = std.math.maxInt(i32);
    var i: i16 = 0;
    while (i < 2000) : (i += 1) {
        var sum: i32 = 0;
        for (nums.items) |num|
            sum += try sumFunc(num - i);
        if (sum < min_sum)
            min_sum = sum;
    }
    print("{}", .{min_sum});
}

fn sumFunc(num: i32) !i32 {
    return try std.math.absInt(num);
}
