const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const print = std.log.info;

pub fn main() !void {
    var scores = std.ArrayList(u35).init(&gpa.allocator);

    var lines_it = std.mem.tokenize(input, "\n");
    while (lines_it.next()) |line| {
        const score = try cal_score(line);
        if (score != 0) try scores.append(score);
    }
    std.sort.sort(u35, scores.items, {}, comptime std.sort.asc(u35));
    print("{}", .{scores.items[scores.items.len / 2]});
}

fn cal_score(line: []const u8) !u35 {
    var charstack = std.ArrayList(u8).init(&gpa.allocator);
    defer charstack.deinit();

    for (line) |char| {
        switch (char) {
            '(', '[', '{', '<' => try charstack.append(char),
            else => {
                const opening = charstack.pop();
                if (char != try closed(opening))
                    return 0;
            },
        }
    }
    var score: u35 = 0;
    while (charstack.items.len != 0) {
        const left = charstack.pop();
        score *= 5;
        score += try errors(try closed(left));
    }
    return score;
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

fn errors(end: u8) !u4 {
    return switch (end) {
        ')' => 1,
        ']' => 2,
        '}' => 3,
        '>' => 4,
        else => unreachable,
    };
}
