const std = @import("std");
// Arrays are fixed sized with a length known at compile time.
const a = [5]i32{ 1, 2, 3, 4, 5 };

// we already saw this .{...} syntax with structs
// it works with arrays too
const b: [5]i32 = .{ 1, 2, 3, 4, 5 };

// use _ to let the compiler infer the length
const c = [_]i32{ 1, 2, 3, 4, 5 };

// A slice on the other hand is a pointer to an array with a length. The length is known at runtime.
const s_a = [_]i32{ 1, 2, 3, 4, 5 };
const s_b = a[1..4];

pub fn main() !void {
    var end: usize = 3;
    end += 1;
    const s_c = s_a[1..end];
    std.debug.print("{any}\n", .{@TypeOf(b)});
    std.debug.print("array:\na:{d}\nb:{d}\nc:{d}\ns_a:{d}\ns_b:{d}\ns_c:{d}\n", .{ a.len, b.len, c.len, s_a.len, s_b.len, s_c.len });
}

// If we tried to write into b, such as b[2] = 5;
// we'd get a compile time error:
// cannot assign to constant. This is because of b's type.

// To solve this, you might be tempted to make this change:

// replace const with var
// var b = a[1..end];
//
// but you'll get the same error, why? As a hint,
// what's b's type, or more generically, what is b?
// A slice is a length and pointer to [part of] an array.
// A slice's type is always derived from what it is slicing.
// Whether b is declared const or not, it is a slice of a [5]const i32
// and so b must be of type []const i32. If we want to be able to write
// into b, we need to change a from a const to a var.

// pub fn main() void {
// 	var a = [_]i32{1, 2, 3, 4, 5};
// 	var end: usize = 3;
// 	end += 1;
// 	const b = a[1..end];
// 	b[2] = 99;
// }
// This works because our slice is no longer []const i32 but rather []i32.
// You might reasonably be wondering why this works when b is still a const.
// But the const-ness of b relates to b itself, not the data that b points to.
// Well, I'm not sure that's a great explanation, but for me, this code highlights
// the difference:

// pub fn main() void {
// 	var a = [_]i32{1, 2, 3, 4, 5};
// 	var end: usize = 3;
// 	end += 1;
// 	const b = a[1..end];
// 	b = b[1..];
// }
// This won't compile; as the compiler tells us, we cannot assign to constant.
// But if we had done var b = a[1..end];, then the code would have worked
// because b itself is no longer a constant.
