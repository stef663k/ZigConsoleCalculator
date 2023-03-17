const std = @import("std");

pub fn main() !void {
    var allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer allocator - deinit();

    const input_stream = try std.io.getStdIn().reader();
    var input_slice: []u8 = try allocator.alloc(u8, 1024);

    while (true) {}
}
