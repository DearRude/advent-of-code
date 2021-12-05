const std = @import("std");
const input = @embedFile("input.txt");
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const MAX = 1000;
const print = std.log.info;

const Vent = struct {
    x_or: u16,
    x_de: u16,
    y_or: u16,
    y_de: u16,
};

pub fn main() !void {
    var diagram: [MAX][MAX]u8 = undefined;
    std.mem.set(u8, @ptrCast(*[MAX * MAX]u8, &diagram), 0);

    var lines_it = std.mem.tokenize(input, "\n");

    while (lines_it.next()) |line| {
        const v: Vent = try parseVent(&std.mem.tokenize(line, " -> "));
        const so_v = try sortVent(v);

        const diag: bool = ((so_v.y_de - so_v.y_or) == (so_v.x_de - so_v.x_or));
        const rev: bool = (v.x_or != so_v.x_or) != (v.y_or != so_v.y_or);

        if (v.x_or == v.x_de or v.y_or == v.y_de) { // Staight
            for (diagram[so_v.x_or .. so_v.x_de + 1]) |*row| {
                for (row[so_v.y_or .. so_v.y_de + 1]) |*val|
                    val.* += 1;
            }
        } else if (diag and !rev) { // Normal diagonal
            var it = so_v.x_or;
            while (it <= so_v.x_de) : (it += 1)
                diagram[it][it - so_v.x_or + so_v.y_or] += 1;
        } else if (diag and rev) { // Reverse diagonal
            var it = so_v.x_or;
            while (it <= so_v.x_de) : (it += 1)
                diagram[it][so_v.x_or + so_v.y_de - it] += 1;
        }
    }
    print("{}", .{calcLongs(&diagram)});
}

fn calcLongs(diag: *[MAX][MAX]u8) u32 {
    var ans: u32 = 0;
    for (diag) |row| {
        for (row) |val| {
            if (val >= 2)
                ans += 1;
        }
    }
    return ans;
}

fn sortVent(vent: Vent) !Vent {
    return Vent{
        .x_or = if (vent.x_or <= vent.x_de) vent.x_or else vent.x_de,
        .x_de = if (vent.x_or <= vent.x_de) vent.x_de else vent.x_or,
        .y_or = if (vent.y_or <= vent.y_de) vent.y_or else vent.y_de,
        .y_de = if (vent.y_or <= vent.y_de) vent.y_de else vent.y_or,
    };
}

fn parseVent(it: *std.mem.TokenIterator) !Vent {
    var origin = std.mem.tokenize(it.next().?, ",");
    var destin = std.mem.tokenize(it.next().?, ",");

    return Vent{
        .x_or = try std.fmt.parseUnsigned(u16, origin.next().?, 10),
        .y_or = try std.fmt.parseUnsigned(u16, origin.next().?, 10),
        .x_de = try std.fmt.parseUnsigned(u16, destin.next().?, 10),
        .y_de = try std.fmt.parseUnsigned(u16, destin.next().?, 10),
    };
}
