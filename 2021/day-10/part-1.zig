const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const print = std.log.info;

pub fn main() !void {
    var ans: u19 = 0;

    var lines_it = std.mem.tokenize(input, "\n");
    while (lines_it.next()) |line| {
        ans += try cal_error(line);
    }

    print("{}", .{ans});
}

fn cal_error(line: []const u8) !u19 {
    var charstack = std.ArrayList(u8).init(&gpa.allocator);
    defer charstack.deinit();

    for (line) |char| {
        switch (char) {
            '(', '[', '{', '<' => try charstack.append(char),
            else => {
                const opening = charstack.pop();
                if (char != try closed(opening))
                    return try errors(char);
            },
        }
    }
    return 0;
}

fn closed(start: u8) !u8 {
    return switch (start) {
        '(' => return ')',
        '[' => return ']',
        '{' => return '}',
        '<' => return '>',
        else => unreachable,
    };
}

fn errors(end: u8) !u15 {
    return switch (end) {
        ')' => 3,
        ']' => 57,
        '}' => 1197,
        '>' => 25137,
        else => unreachable,
    };
}
