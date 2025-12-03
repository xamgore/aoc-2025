const day01 = @import("day01.zig");

pub fn main() !void {
    try day01.main();
}

test "import" {
    _ = day01;
}
