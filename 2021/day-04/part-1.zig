const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const SIZE: u8 = 5;

pub fn main() !void {
    var lines_it = std.mem.tokenize(input, "\n");

    var nums_it = std.mem.tokenize(lines_it.next().?, ",");
    var nums = std.ArrayList(u8).init(&gpa.allocator);
    while (nums_it.next()) |num|
        try nums.append(try std.fmt.parseInt(u8, num, 10));

    var boards = blk: {
        var boards = std.ArrayList([SIZE * SIZE]u8).init(&gpa.allocator);
        var board: [SIZE * SIZE]u8 = undefined;

        var b_idx: u8 = 0;
        while (lines_it.next()) |line| : (b_idx += SIZE) {
            if (b_idx == SIZE * SIZE) {
                b_idx = 0;
                try boards.append(board);
            }
            var lineIt = std.mem.tokenize(line, " ");
            for (board[b_idx .. b_idx + SIZE]) |_, idx|
                board[b_idx + idx] = try std.fmt.parseInt(u8, lineIt.next().?, 10);
        }
        break :blk boards;
    };

    // Mark the first 4
    for (nums.items[0..4]) |num, idx| {
        for (boards.items) |*board|
            markNumber(board, num);
    }

    // The rest
    outer: for (nums.items[4..nums.items.len]) |num, idx| {
        for (boards.items) |*board| {
            markNumber(board, num);
            if (haveWon(board)) {
                std.log.info("{}", .{caclRemain(board) * num});
                break :outer;
            }
        }
    }
}

fn caclRemain(board: *[SIZE * SIZE]u8) u16 {
    var sum: u16 = 0;
    for (board) |val| {
        if (val != 0xff)
            sum += val;
    }
    return sum;
}

fn haveWon(board: *[SIZE * SIZE]u8) bool {
    var sums: [2 * SIZE]u16 = undefined;
    std.mem.set(u16, &sums, 0);
    for (board) |val, i| {
        sums[(i / SIZE) + SIZE] += val;
        sums[i % SIZE] += val;
    }
    for (sums) |sum| {
        if (sum == (0xff * 5))
            return true;
    }
    return false;
}

fn markNumber(board: *[SIZE * SIZE]u8, num: u8) void {
    for (board) |*val| {
        if (val.* == num)
            val.* = 0xff;
    }
}
