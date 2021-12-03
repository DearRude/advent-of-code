const std = @import("std");
const input = @embedFile("input.txt");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var lines = std.mem.tokenize(input, "\n");

    var li = lines;
    const count_column: u32 = @intCast(u32, li.next().?.len);
    var count_line: u32 = 1;
    while (li.next()) |_| : (count_line += 1) {}

    var mosts: []bool = try gpa.allocator.alloc(bool, count_line);
    for (mosts) |*v|
        v.* = true;
    var leasts: []bool = try gpa.allocator.alloc(bool, count_line);
    for (leasts) |*v|
        v.* = true;

    var one: u32 = 0;
    var zero: u32 = 0;
    var idx: u32 = 0;
    while (idx < count_column) : (idx += 1) {
        var count_zero: u32 = 0;
        var total_zero: u32 = 0;
        var count_one: u32 = 0;
        var total_one: u32 = 0;

        li = lines;
        var i: u32 = 0;
        while (li.next()) |binary| : (i += 1) {
            if (mosts[i]) {
                total_one += 1;
                one = try std.fmt.parseUnsigned(u32, binary, 2);
            }
            if (leasts[i]) {
                total_zero += 1;
                zero = try std.fmt.parseUnsigned(u32, binary, 2);
            }
            if (binary[idx] == '0' and leasts[i])
                count_zero += 1;
            if (binary[idx] == '1' and mosts[i])
                count_one += 1;
        }

        const least_selected = count_zero > total_zero / 2;
        const most_selected = count_one >= total_one / 2;
        li = lines;
        i = 0;
        while (li.next()) |binary| : (i += 1) {
            if (binary[idx] == '1' and !least_selected)
                leasts[i] = false;
            if (binary[idx] == '1' and !most_selected)
                mosts[i] = false;
            if (binary[idx] == '0' and least_selected)
                leasts[i] = false;
            if (binary[idx] == '0' and most_selected)
                mosts[i] = false;
        }
    }
    std.log.info("{}", .{one * zero});
}
