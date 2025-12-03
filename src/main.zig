const day01 = @import("day01.zig");
const day02 = @import("day02.zig");

pub fn main() !void {
    try day02.main();
}

test "import" {
    _ = day01;
    _ = day02;
}
