const std = @import("std");
// Zig's for loop is used to iterate over arrays, slices and ranges.
// For example, to check if an array contains a value, we might write:
fn contains(haystack: []const u32, needle: u32) bool {
    for (haystack) |value| {
        if (needle == value) {
            return true;
        }
    }
    return false;
}

// for loops can work on multiple sequences at once,
// as long as those sequences are the same length.
// Above we used the std.mem.eql function. Here's what it (almost) looks like:

pub fn eql(comptime T: type, a: []const T, b: []const T) bool {
    // if they arent' the same length, the can't be equal
    if (a.len != b.len) return false;

    for (a, b) |a_elem, b_elem| {
        if (a_elem != b_elem) return false;
    }

    return true;
}
// The initial if check isn't just a nice performance optimization,
// it's a necessary guard. If we take it out and pass arguments
// of different lengths, we'll get a runtime panic: for loop over objects
// with non-equal lengths.
fn func1() void {
    // for loops can also iterate over ranges, such as:
    for (0..10) |i| {
        std.debug.print("{d}\n", .{i});
    }
}

// for range uses two dots, (0..10). That's because for is
// exclusive of the upper bound.

// This really shines in combination with one (or more!) sequence:
fn indexOf(haystack: []const u32, needle: u32) ?usize {
    for (haystack, 0..) |value, i| {
        if (needle == value) {
            return i;
        }
    }
    return null;
}

// The end of the range is inferred from the length of haystack,
// though we could punish ourselves and write: 0..hastack.len. for loops
// don't support the more generic init; compare; step idiom.
// For this, we rely on while.

// Because while is simpler, taking the form of while (condition) { },
// we have greater control over the iteration. For example,
// when counting the number of escape sequences in a string,
// we need to increment our iterator by 2 to avoid double counting a \:
const src: []const u8 = "danial";
fn func2() void {
    var escape_count: usize = 0;
    {
        var i: usize = 0;
        while (i < src.len) {
            // backslash is used as an escape character, thus we need to escape it...
            // with a backslash.
            if (src[i] == '\\') {
                i += 2;
                escape_count += 1;
            } else {
                i += 1;
            }
        }
    }
}
// We added an explicit block around our temporary i variable and while loop.
// This narrows the scope of i. Blocks like this can be useful, though in
// this case it's probably overkill. Still, the above example is as close
// to a traditional for(init; compare; step) loop that Zig has.

// A while can have an else clause, which is executed when the
// condition is false. It also accepts a statement to execute
// after each iteration. There can be multiple statements speparated
// with ;. This feature was commonly used prior to for supporting multiple
// sequences. The above can be written as:
fn func3() void {
    var i: usize = 0;
    var escape_count: usize = 0;

    //                  this part
    while (i < src.len) : (i += 1) {
        if (src[i] == '\\') {
            // +1 here, and +1 above == +2
            i += 1;
            escape_count += 1;
        }
    }
}
// break and continue are supported for either breaking out of the inner-most
// loop or jumping to the next iteration.

// Blocks can be labeled and break and continue can target a specific
// label. A contrived example:
fn name() void {
    outer: for (1..10) |i| {
        for (i..10) |j| {
            if (i * j > (i + i + j + j)) continue :outer;
            std.debug.print("{d} + {d} >= {d} * {d}\n", .{ i + i, j + j, i, j });
        }
    }
}

fn func4() !void {
    // const personality_analysis = "danial";
    const tea_vote = "danial";
    const coffee_vote = "danial";
    // break has another interesting behavior, returning a value from a block:
    const personality_analysis = blk: {
        if (tea_vote > coffee_vote) break :blk "sane";
        if (tea_vote == coffee_vote) break :blk "whatever";
        if (tea_vote < coffee_vote) break :blk "dangerous";
    };
    // Blocks like this must be semi-colon terminated.
    return personality_analysis;
}

// Later, when we explore tagged unions, error unions and optional
// types, we'll see what else these control flow structures have to offer.
