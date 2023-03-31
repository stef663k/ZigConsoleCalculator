const std = @import("std");

pub fn main() !void {
    //Get standard input and output
    var input = std.io.getStdIn().reader();
    var output = std.io.getStdOut().writer();

    //Initiating allocator
    var allocator = std.heap.page_allocator;

    //It works without buffer as we allocate the memory in line
    // var buffer = try allocator.alloc(u8, 1024);
    // defer allocator.free(buffer);

    while (true) {

        //Reads the input from console and allocate memory
        try output.print("Enter you calculation: ", .{});
        var line = try input.readAllAlloc(allocator, 1024);
        if (line.len == 0) break;
        //Parsing the input to float
        var result: f64 = undefined;
        try std.fmt.parseFloat(result, line);
        //Prints the output to console
        try output.print("result: {}\n", .{result});
    }
}
