Numeric octal mode for file permissions settings may not seem very familiar to newbies, but it can be very convenient if we understand the principle. As you probably know, our widely used 0-9 numbering system is not the only one in the world. It is base ten positional decimal system. But we can use number systems with other bases. For example, we know a binary system with only two digits in the base - 0 and 1. Or the hexadecimal system with numbers 0 through 9 and letters A through F for the missing 6 numbers. Or the Sumerian-Babylonian Sexagesimal number system with sixty in the base and we still use it in time measuring.

The decimal system has historically been most widely used only because we have ten fingers on our hands. Binary representation of numbers is closest to computing equipment. And hexadecimal is the most compact - each byte is encoded with just two hexadecimal numbers.

But what about octal numbering? Oddly enough, but the octal numbering is closest to the human perception of computer data. Octal numerals can be made from binary numerals by grouping consecutive binary digits into groups of three (starting from the right). We just need to sum the powers of two in the corresponding positions:
0) two to the zero power equals one
1) two to the power of one equals two
2) two to the power of two equals four

We just need to sum the powers of two in the sequential positions of the binary triplet, where we see one. For example, all zeros mean zero, and all ones mean one plus two plus four, which is seven. For file access rights, each three-bit group of rights (read, write, execute for user, group and others) can be represented by one [octal number](https://en.wikipedia.org/wiki/Chmod#Octal_modes). For example:
* All permissions for the owner and completely denied access for everyone else -- equals 700.
* Only owner and group can read and write, and everyone else can only read -- 664.
* The same with execution permissions for all -- 775.
