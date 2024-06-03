const std = @import("std");
const model_user = @import("models/user.zig");
const MAX_POWER = model_user.MAX_POWER;
const user = model_user.User{
    .power = MAX_POWER,
    .name = "Goku",
};

pub fn main() void {
    std.debug.print("{s} power is {d}\n", .{ user.name, user.power });
}
// If our User struct wasn't marked as pub we'd get the following error: 'User' is not marked 'pub'.
