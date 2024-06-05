// Zig's if, else if and else are commonplace:

// std.mem.eql does a byte-by-byte comparison
// for a string it'll be case sensitive
if (std.mem.eql(u8, method, "GET") or std.mem.eql(u8, method, "HEAD")) {
// handle a GET request
} else if (std.mem.eql(u8, method, "POST")) {
// handle a POST request
} else {
// ...
}

// The above example is comparing ASCII strings and should likely be case
// insensitive. std.ascii.eqlIgnoreCase(str1, str2) is probably a better option.
// There is no ternary operator, but you can use an if/else like so:
const super = if (power > 9000) true else false;
