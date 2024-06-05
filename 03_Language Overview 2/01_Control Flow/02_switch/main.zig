// switch is similar to an if/else if/else, but has the advantage of
// being exhaustive. That is, it's a compile-time error if not all cases
// are covered. This code will not compile:
fn anniversaryName(years_married: u16) []const u8 {
    switch (years_married) {
        1 => return "paper",
        2 => return "cotton",
        3 => return "leather",
        4 => return "flower",
        5 => return "wood",
        6 => return "sugar",
        //        Yes, but thankfully there's an else:
        else => return "no more gifts for you",
    }
}

// We can combine multiple cases or use ranges, and use blocks for complex cases:
fn arrivalTimeDesc(minutes: u16, is_late: bool) []const u8 {
    switch (minutes) {
        0 => return "arrived",
        1, 2 => return "soon",
        3...5 => return "no more than 5 minutes",
        else => {
            if (!is_late) {
                return "sorry, it'll be a while";
            }
            // todo, something is very wrong
            return "never";
        },
    }
}
// Our switch range used three dots, (3...6). That's because switch cases
// are inclusive of both numbers.
