const std = @import("std");
//
// pub const User = struct {
//     power: u64,
//     name: []const u8,
// };

//Struct can be given a default value.
// When we create a struct, every field has to be set.
//
// pub const User = struct {
//     power: u64 = 0,
//     name: []const u8,
// };

// Structs can have methods, they can contain declarations (including other structs)
// and they might even contain zero fields, at which point
// they act more like a namespace.
//
pub const User = struct {
    power: u64 = 0,
    name: []const u8,

    pub const SUPER_POWER = 9000;

    fn diagnose(user: User) void {
        if (user.power >= SUPER_POWER) {
            std.debug.print("it's over {d}!!!", .{SUPER_POWER});
        }
    }

    // pub fn init(name: []const u8, power: u64) User {
    //     return User{
    //         .name = name,
    //         .power = power,
    //     };
    // }

    pub fn init(name: []const u8, power: u64) User {
        // instead of return User{...}
        return .{
            .name = name,
            .power = power,
        };
    }
};

// Methods are just normal functions that can be called with a dot syntax
//
// call diagnose on user
// user.diagnose();

// The above is syntactical sugar for:
// User.diagnose(user);

// const user = User{
//     .power = 9001,
//     .name = "Goku",
// };

// const user: User = User{
//     .power = 9001,
//     .name = "Goku",
// };

// const user: User = .{
//     .power = 9001,
//     .name = "Goku",
// };
