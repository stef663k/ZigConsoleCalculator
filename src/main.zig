const std = @import("std");

pub fn main() !void {
    var buffer: [20]u8 = undefined;

    var reader = std.io.getStdIn().reader().setBufferSize(buffer[0..].len);
    var writer = std.io.getStdOut().writer();
}
