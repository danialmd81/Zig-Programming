const std = @import("std");

const Number = union {
    int: i64,
    float: f64,
    nan: void,
};

const TimestampType = enum {
    unix,
    datetime,
};

const Timestamp = union(TimestampType) {
    unix: i32,
    datetime: DateTime,

    const DateTime = struct {
        year: u16,
        month: u8,
        day: u8,
        hour: u8,
        minute: u8,
        second: u8,
    };

    fn seconds(self: Timestamp) u16 {
        switch (self) {
            .datetime => |dt| return dt.second,
            .unix => |ts| {
                const seconds_since_midnight: i32 = @rem(ts, 86400);
                return @intCast(@rem(seconds_since_midnight, 60));
            },
        }
    }
};
// Notice that each case in our switch captures the typed value of the field.
// That is dt is a Timestamp.DateTime and ts is an i32. This is also the first
// time we've seen a structure nested within another type. DateTime could have
// been defined outside of the union. We're also seeing two new builtin
// functions: @rem to get the remainder and @intCast to convert the result
// to an u16 (@intCast infers that we want an u16 from our return type since
// the value is being returned).

// As we can see from the above example, tagged unions can be used somewhat
// like interfaces, as long as all possible implementations are known ahead
// of time and can be baked into the tagged union.

// Finally, the enum type of a tagged union can be inferred.
// Instead of defining a TimestampType, we could have done:

// const Timestamp = union(enum) { unix: i32, datetime: DateTime };

// and Zig would have created an implicit enum based on our union's fields.

pub fn main() void {

    // An union defines a set of types that a value can have.
    // For example, this Number union can either be an integer, a float or
    // a nan (not a number):
    const n = Number{ .int = 32 };
    std.debug.print("{d}\n", .{n.int});

    // A union can only have one field set at a time; it's an error
    // to try to access an unset field. Since we've set the int field,
    // if we then tried to access n.float, we'd get an error. One of our
    // fields, nan, has a void type. How would we set its value? Use {}:
    const a = Number{ .nan = {} };
    std.debug.print("{any}\n", .{a.nan});

    // A challenge with unions is knowing which field is set. This is
    // where tagged unions come into play. A tagged union merges an enum with
    // an union, which can be used in a switch statement. Consider this example:
    const ts = Timestamp{ .unix = 1693278411 };
    std.debug.print("{d}\n", .{ts.seconds()});
}
