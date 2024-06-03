// I wish I could say that Zig has a string type and it's awesome.
// Unfortunately it does not, and they are not.
// At its simplest, Zig strings are sequences (i.e. arrays or slices) of bytes (u8).
const std = @import("std");

pub fn main() void {
    // an array of 3 booleans with false as the sentinel value
    const a = [3:false]bool{ false, true, false };

    // This line is more advanced, and is not going to get explained!
    std.debug.print("{any}\n", .{std.mem.asBytes(&a).*});
}
// Zig will coerce the type for you.
// It'll do this between a few different types,
// but it's most obvious with strings.
// It means that if a function has a []const u8 parameter, or a structure
// has a []const u8 field, string literals can be used.
// Because null terminated strings are arrays, and arrays have a
// known length, this coercion is cheap, i.e.
// it does not require iterating through the string to find the null terminator.

// So, when talking about strings, we usually mean a []const u8.
// When necessary we explicitly state a null terminated string,
// which can be automatically coerced into a []const u8.
// But do remember that a []const u8 is also used to represent arbitrary binary data,
// and as such, Zig doesn't have the notion of a string that higher level programming languages do.
// Furthermore, Zig's standard library only has a very basic unicode module.
