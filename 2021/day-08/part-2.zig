const std = @import("std");
const input = @embedFile("input.txt");
const print = std.log.info;

pub fn main() !void {
    var ans: u32 = 0;
    var decoded: [4]u8 = undefined;
    std.mem.set(u8, &decoded, 0);

    var lines_it = std.mem.tokenize(input, "\n,");
    while (lines_it.next()) |line| {
        var part_it = std.mem.tokenize(line, "|");
        const maps = encode(part_it.next().?);
        var nums_it = std.mem.tokenize(part_it.next().?, " ");

        var i: u8 = 0;
        while (nums_it.next()) |num| : (i += 1)
            decoded[i] = decode(num, maps);
        ans += try std.fmt.parseUnsigned(u16, decoded[0..4], 10);
    }
    print("{}", .{ans});
}

fn encode(learn: []const u8) [2]u8 {
    var nums_it = std.mem.tokenize(learn, " ");
    const one = blk: {
        var it = nums_it;
        var one: []const u8 = undefined;
        while (it.next()) |num| {
            if (num.len == 2) one = num;
        }
        break :blk one;
    };
    const six = blk: {
        var it = nums_it;
        var six: []const u8 = undefined;
        while (it.next()) |num| {
            const one_in = std.mem.containsAtLeast(u8, num, 1, one[0..1]);
            const two_in = std.mem.containsAtLeast(u8, num, 1, one[1..2]);
            if (num.len == 6 and !(one_in and two_in)) six = num;
        }
        break :blk six;
    };
    const upper_right = blk: {
        var upper = one[0..1];
        if (std.mem.containsAtLeast(u8, six, 1, one[0..1]))
            upper = one[1..2];
        break :blk upper;
    };
    const five = blk: {
        var it = nums_it;
        var five: []const u8 = undefined;
        while (it.next()) |num| {
            const upper_in = std.mem.containsAtLeast(u8, num, 1, upper_right);
            if (num.len == 5 and !upper_in) five = num;
        }
        break :blk five;
    };
    const down_left = blk: {
        var down: []const u8 = undefined;
        for (six) |_, idx| {
            if (!std.mem.containsAtLeast(u8, five, 1, six[idx .. idx + 1]))
                down = six[idx .. idx + 1];
        }
        break :blk down;
    };
    var maps: [2]u8 = undefined;
    std.mem.set(u8, &maps, '1');
    maps[0] = upper_right[0];
    maps[1] = down_left[0];
    return maps;
}

fn decode(inp: []const u8, map: [2]u8) u8 {
    const count_ans = switch (inp.len) {
        2 => '1',
        3 => '7',
        4 => '4',
        7 => '8',
        else => @intCast(u8, 0),
    };
    if (count_ans != 0)
        return count_ans;
    if (inp.len == 6) {
        const one_in = std.mem.containsAtLeast(u8, inp, 1, map[0..1]);
        const two_in = std.mem.containsAtLeast(u8, inp, 1, map[1..2]);
        if (one_in and two_in) {
            return '0';
        } else if (one_in) {
            return '9';
        } else {
            return '6';
        }
    }
    if (inp.len == 5) {
        const one_in = std.mem.containsAtLeast(u8, inp, 1, map[0..1]);
        const two_in = std.mem.containsAtLeast(u8, inp, 1, map[1..2]);
        if (one_in and two_in) {
            return '2';
        } else if (one_in) {
            return '3';
        } else {
            return '5';
        }
    }
    return 0;
}
