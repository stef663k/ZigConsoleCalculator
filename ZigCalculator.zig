const std = @import("std");

pub fn main() !void {
    var input = std.io.getStdIn().reader();
    var output = std.io.getStdOut().writer();

    var allocator = std.heap.page_allocator;
    var buffer = try allocator.alloc(u8, 1024);

    defer allocator.free(buffer);

    while (true) {
        try output.print("Enter you calculation: ", .{});
        var line = try input.readAllAlloc(allocator, 1024);
        if (line.len == 0) break;

        var result: f64 = undefined;
        try std.fmt.parseFloat(result, line);

        try output.print("result: {}\n", .{result});
    }
}
