const std = @import("std");

pub fn main() void {
    const sum = add(8999, 2);
    std.debug.print("8999 + 2 = {d}\n", .{sum});
}

fn add(a: i64, b: i64) i64 {
    return a + b;
}

// We'll get an error on a += b;: cannot assign to constant.
// This is an important lesson that we'll revisit in greater detail later:
// function parameters are constants.
// fn add(a: i64, b: i64) i64 {
// 	a += b;
// 	return a;
// }

// For the sake of improved readability,
// there is no function overloading (the same function named
// defined with different parameter types and/or number of parameters).

// The next thing to note is the i64 type: a 64-bit signed integer.
// Some other numeric types are:
// u8, i8, u16, i16, u32, i32, u47, i47, u64, i64, f32 and f64.
// The inclusion of u47 and i47 isn't a test to make sure you're still awake;
// Zig supports arbitrary bit-width integers.
// Though you probably won't use these often, they can come in handy.
// One type you will use often is usize
// which is an unsigned pointer sized integer and generally
// the type that represents the length/size of something.

// In addition to f32 and f64, Zig also supports f16, f80 and f128 floating point types.
