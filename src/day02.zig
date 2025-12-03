const std = @import("std");

pub fn main() !void {
    const input = @embedFile("day02-test.txt");

    var tok = std.mem.tokenizeAny(u8, input, " ,\n");
    var sum: u64 = 0;

    while (tok.next()) |range| {
        if (range.len == 0) break;
        var iter = std.mem.splitScalar(u8, range, '-');
        const from: u64 = try std.fmt.parseInt(u64, iter.next().?, 10);
        const to: u64 = 1 + try std.fmt.parseInt(u64, iter.next().?, 10);

        for (from..to) |num| {
            if (superSilly(num)) sum += num;
        }
    }

    std.debug.print("sum: {}\n", .{ sum });
}

fn silly(number: u64) bool {
    const len: u64 = 1 + std.math.log10_int(number);
    if (len % 2 != 0) return false;
    const divider = std.math.powi(u64, 10, len / 2) catch unreachable;
    return number / divider == number % divider;
}

fn superSilly(number: u64) bool {
    const len: u64 = 1 + std.math.log10_int(number);
    outer: for (2..len + 1) |ps| {
        if (len % ps != 0) continue;
        const divider = std.math.powi(u64, 10, len / ps) catch unreachable;

        var up = number;
        const lo = number % divider;
        // std.debug.print("number: {}, parts: {}, len: {}, divider: {}, lo: {}, up: {}\n", .{ number, ps, len, divider, lo, up });
        while (up != 0) : (up /= divider) {
            if (up % divider != lo) {
                continue :outer;
            }
        }
        return true;
    }
    return false;
}

const expect = std.testing.expect;

test "these-are-silly" {
    try expect(silly(11));
    try expect(silly(1010));
    try expect(silly(38593859));
}

test "these-are-not" {
    try expect(!silly(1));
    try expect(!silly(10));
    try expect(!silly(101));
    try expect(!silly(1011));
}

test "these-are-super-silly" {
    try expect(superSilly(11));
    try expect(superSilly(1010));
    try expect(superSilly(12341234)); // 2
    try expect(superSilly(123123123)); // 3
    try expect(superSilly(1212121212)); // 5
    try expect(superSilly(1111111)); // 7
}

test "these-are-super-not" {
    try expect(!superSilly(1));
    try expect(!superSilly(10));
    try expect(!superSilly(101));
    try expect(!superSilly(1011));
}
