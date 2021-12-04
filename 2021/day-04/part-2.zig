const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const SIZE: u8 = 5;

const Board = struct {
    vals: [SIZE * SIZE]u8,
    won_at: u16 = 0,
    won: bool = false,
};

pub fn main() !void {
    var lines_it = std.mem.tokenize(input, "\n");

    var nums_it = std.mem.tokenize(lines_it.next().?, ",");
    var nums = std.ArrayList(u8).init(&gpa.allocator);
    while (nums_it.next()) |num|
        try nums.append(try std.fmt.parseInt(u8, num, 10));

    var boards = blk: {
        var boards = std.ArrayList(Board).init(&gpa.allocator);
        var board: Board = .{ .vals = undefined };
        var b_idx: u8 = 0;
        while (lines_it.next()) |line| : (b_idx += SIZE) {
            if (b_idx == SIZE * SIZE) {
                b_idx = 0;
                try boards.append(board);
            }
            var lineIt = std.mem.tokenize(line, " ");
            for (board.vals[b_idx .. b_idx + SIZE]) |_, idx|
                board.vals[b_idx + idx] = try std.fmt.parseInt(u8, lineIt.next().?, 10);
        }
        break :blk boards;
    };

    // Mark the first 4
    for (nums.items[0..4]) |num, idx| {
        for (boards.items) |*board|
            markNumber(board, num);
    }

    // The rest
    var won_count: u8 = 0;
    outer: for (nums.items[4..nums.items.len]) |num, idx| {
        for (boards.items) |*board| {
            if (board.won) continue;
            markNumber(board, num);
            if (haveWon(board)) {
                board.won = true;
                board.won_at = won_count;
                won_count += 1;
            }
            if (won_count == boards.items.len) {
                std.log.info("{}", .{caclRemain(board) * num});
                break :outer;
            }
        }
    }
}

fn caclRemain(board: *Board) u16 {
    var sum: u16 = 0;
    for (board.vals) |val| {
        if (val != 0xff)
            sum += val;
    }
    return sum;
}

fn haveWon(board: *Board) bool {
    var sums: [2 * SIZE]u16 = undefined;
    std.mem.set(u16, &sums, 0);
    for (board.vals) |val, i| {
        sums[(i / SIZE) + SIZE] += val;
        sums[i % SIZE] += val;
    }
    for (sums) |sum| {
        if (sum == (0xff * 5))
            return true;
    }
    return false;
}

fn markNumber(board: *Board, num: u8) void {
    for (board.vals) |*val| {
        if (val.* == num)
            val.* = 0xff;
    }
}
