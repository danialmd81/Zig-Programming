// You will notice that instead of the logical operators && and ||,
// we use and and or.

// Also, the comparison operator, ==, does not work between slices,
// such as []const u8, i.e. strings. In most cases, you'll use
// std.mem.eql(u8, str1, str2) which will compare the length and then
// bytes of the two slices.
