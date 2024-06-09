const std = @import("std");
// Enums are integer constants that are given a label. They are defined much
// like a struct:

// could be "pub"
const Status = enum {
    ok,
    bad,
    unknown,
};

// And, like a struct, can contain other definitions, including functions which
// may or may not take the enum as a parameter:

const Stage = enum {
    validate,
    awaiting_confirmation,
    confirmed,
    err,

    fn isComplete(self: Stage) bool {
        return self == .confirmed or self == .err;
    }
};

// If you want the string representation of an enum, you can use
// the builtin @tagName(enum) function.
// Recall struct types can be inferred based on their assigned or
// return type using the .{...} notation. Above, we see the enum type
// being inferred based on its comparison to self, which is of type Stage.
// We could have been explicit and written: return self == Stage.confirmed
// or self == Stage.err;. But, when dealing with enums you'll often see
// the enum type omitted via the .$value notation. This is called an enum literal.

// The exhaustive nature of switch makes it pair nicely with enums as it
// ensures you've handled all possible cases. Be careful when using the else
// clause of a switch though, as it'll match any newly added enum values,
// which may or may not be the behavior that you want.

pub fn main() !void {
    const var1: Status = Status.bad;
    const var2: Stage = Stage.awaiting_confirmation;
    std.debug.print("{any}, {any}, {any}\n", .{ var1, var2, var2.isComplete() });
}
