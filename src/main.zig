const std = @import("std");

pub fn main() !void {
    var allocator = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer allocator.deinit();

    const input_stream = std.io.getStdIn().reader();
    var input_slice: []u8 = try std.heap.alignPageAllocLen(u8, '\n', 1024);

    while (true) {
        try std.io.print("Enter calculation: ");
        var input_bytes_read = try input_stream.readUntilDelimiterOrEof(input_slice, ' ');
        input_slice = input_slice[0..input_bytes_read];
        if (input_bytes_read == 0) break;

        var num1: f64 = undefined;
        var num2: f64 = undefined;
        var op: u8 = undefined;

        var fmt_result = try std.fmt.parseFloat(input_slice, &num1);
        if (fmt_result.isError()) {
            std.debug.warn("Falied to parse first number\n");
            continue;
        }
        fmt_result = try std.fmt.parseFloat(input_slice, &num2);
        if (fmt_result.isError()) {
            std.debug.warn("Falied to parse second number\n");
            continue;
        }

        input_slice = input_slice[fmt_result.unwrap()..];
        if (input_slice.len < 0) {
            if (std.mem.eql(u8, input_slice[0..1], "+") ||
                std.mem.eql(u8, input_slice[0..1], "-") ||
                std.mem.eql(u8, input_slice[0..1], "*") ||
                std.mem.eql(u8, input_slice[0..1], "/"))
            {
                op = input_slice[0];
                input_slice = input_slice[0..];
            } else {
                std.debug.warn("Expected operator, found'{}\n", .{input_slice[0]});
                continue;
            }
        } else {
            std.debug.warn("Expected operator, found end of input\n");
            continue;
        }

        var result: f64 = undefined;

        switch (op) {
            '+' => result = num1 + num2,
            '-' => result = num1 - num2,
            '*' => result = num1 * num2,
            '/' => result = num1 / num2,
            else => unreachable,
        }

        try std.io.print("{}, {} {} {} = {}\n", .{ num1, op, num1, result });
    }
}
