const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const print = std.log.info;

const LI = 10;

const moves = blk: {
    var mo: [9][2]u2 = undefined;
    for (mo) |*m, i|
        m.* = [2]u2{ i % 3, i / 3 };
    break :blk mo;
};

const coords = blk: {
    var co: [LI * LI][2]u4 = undefined;
    for (co) |*c, i|
        c.* = [2]u4{ i % LI, i / LI };
    break :blk co;
};

pub fn main() !void {
    var oct: [LI][LI]u8 = undefined;
    var flashed: [LI][LI]bool = undefined;
    std.mem.set(bool, @ptrCast(*[LI * LI]bool, &flashed), false);

    var ans: u32 = 0;

    var lines_it = std.mem.tokenize(input, "\n");

    for (oct) |*row|
        row.* = lines_it.next().?.ptr[0..LI].*;

    var i: u8 = 0;
    while (i < 100) : (i += 1) {
        for (coords) |c|
            oct[c[0]][c[1]] += 1;
        for (coords) |c|
            ans += addone(c[0], c[1], &oct, &flashed);
        std.mem.set(bool, @ptrCast(*[LI * LI]bool, &flashed), false);
        for (coords) |c| {
            if (oct[c[0]][c[1]] > '9')
                oct[c[0]][c[1]] = '0';
        }
    }
    print("{}", .{ans});
}

fn addone(i: usize, j: usize, oct: *[LI][LI]u8, fl: *[LI][LI]bool) u8 {
    if (fl[i][j] == true or oct[i][j] <= '9') return 0;
    fl[i][j] = true;
    var flashed: u8 = 1;
    for (moves) |m| {
        const im = i + m[0];
        const jm = j + m[1];
        if (m[0] == 1 and m[1] == 1) continue;
        if (im > LI or jm > LI or im < 1 or jm < 1) continue;
        oct[im - 1][jm - 1] += 1;
        if (oct[im - 1][jm - 1] > '9')
            flashed += addone(im - 1, jm - 1, oct, fl);
    }
    return flashed;
}
