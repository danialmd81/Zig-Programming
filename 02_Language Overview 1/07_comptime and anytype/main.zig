// The first is Zig's concept of compile-time execution, or comptime.
// This is the core to Zig's metaprogramming capabilities and, as the name
// implies, revolves around running code at compile time, rather than runtime.

const std = @import("std");

// notice the "comptime" before the "user" variable
pub fn print(comptime user: User) void {
    std.debug.print("{s}'s power is {d}\n", .{ user.name, user.power });
}

pub const User = struct { power: u64 = 0, name: []const u8 };

pub fn main() !void {
    print(.{ .name = "Danial", .power = 1000 });
    std.debug.print("{any}\n", .{@TypeOf(.{ .year = 2023, .month = 8 })});
}
