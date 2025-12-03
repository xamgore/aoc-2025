const std = @import("std");

fn process(input: []const u8) !struct { u64, u64 } {
    var pos: u64 = 50;
    var onZero: u64 = 0;
    var crossBy: u64 = 0;

    var tok = std.mem.tokenizeScalar(u8, input, '\n');
    while (tok.next()) |line| {
        if (line.len == 0) continue;
        var rts = try std.fmt.parseInt(u64, line[1..], 10);

        while (rts > 0) : (rts -= 1) {
            pos = if (line[0] == 'R') pos + 1 else 100 + pos - 1;
            pos %= 100;
            crossBy += @intFromBool(pos == 0);
        }

        onZero += @intFromBool(pos == 0);
    }

    return .{ onZero, crossBy };
}

pub fn main() !void {
    const input = @embedFile("day01-test.txt");
    std.debug.print("on zero: {}\ncross by: {}\n", try process(input));
}
