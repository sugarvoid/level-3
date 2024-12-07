pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
--level 3
--by sugarvoid

#include src/main.lua
#include src/boom.lua
#include src/reticle.lua
#include src/missile.lua
#include src/bullet.lua
#include src/building.lua


__gfx__
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee5555eeeeeeeeee8eee8eeeeeeeeee80000000000080000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee99eeeeee88eeeee5555eeeeeeeeee88e8e8e88eee88880000000000000000080800000080000000000000
ee7ee7eeeeee7777eeeeeeeeeeeeeeeeeeeeeeeeee9aa9eeee8998eeee5555eeeeeeeeee8e8eee8ee888eee80000000000000000000000800000800000000000
eee77eeeeeeeeeeeeeee7777eeeeeeeeeeeeeeeee9a77a9ee89aa98eee5555eeeeeeeeee8eeeeeeeeeeeeee80808008008000080000000000000080000000000
eee77eeeee7eeeeeeee7eeeeeeee886ee688eeee9a7777a989aaaa98ee5555eeeeeeeeee8eeeeeeeeeeeeee80000000000000000008000800000000000000000
ee7ee7eeee7eeee7eee7eeeeeee7556556557eee9a7777a989aaaa98ee5555eeeeeeeeee8eeeeeeeeeeeeee80080080000008000000000000080000000000000
eeeeeeeeee7eeeeeeee7eee7eee0336776330eeee9a77a9ee89aa98eeee55eeeeeeeeeee8eeeeeeeeeeeeee80000800800800080080000000800000000000000
eeeeeeeeee7ee7eeeee7ee7eeee0336776330eeeee5555eeee5555eeeee55eeeeeeeeeee8eeeeeeeeeeeeee80800000080000000000080000000800000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0333773330eeeeeeee55eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0333773330eeeeeeee55eeeeeeeeeeeeeeeeeeeeeeeeeeeaaaeaeeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0333773330eeeeeeee88eeeeea99aeeeea9eeeeeeeeeeea9e88e8eeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee0833333380eeeeeeee57eeeea99aeeeea99eeeeea99eeeae99989eeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeeeeeeeeeeeeeeeeee3835555383eeeeeee5575eea989eeeea98aeeeee98aeeea89e8aaeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeeeeeeee9ee9eeeeeeeeee037777777730eeeeee5550ee999aeeee99aeeeeee9aeeeee898aa8eeeeeeeeeeeeeeee00000000000000000000000000000000
eeeee99eeeeeeaaeeeeeeeeeee033333333330eeeeee5055ee9aeeeeeeeeeeeeeeeeeeeeeae8aa9eeeeeeeeeeeeeeeee00000000000000000000000000000000
eeeeeaaeeeeeeeeeeeeeeeeeee00e00ee00e00eeeee00000eeaeeeeeeeeeeeeeeeeeeeeeee89a8e9eeeeeeeeeeeeeeee00000000000000000000000000000000
e3e3e3e355555555e3e3e3e3e3e3e3e344444444ffffffff00000000eeffefef0000000000000000000000000000000000000000000000000000000000000000
3e3e3e3e555555553e3e3e3e3e3e3e3e44444444ffffffff00000000ffffffff0000000000000000000000000000000000000000000000000000000000000000
e3e3e3e355555555e3e00003e300e3e344444444f77ff77f00000000f77ff77f0000000000000000000000000000000000000000000000000000000000000000
3e3e3e3e555555553e04440e3e04003e44444444f77ff77f00000000f77ff77f0000000000000000000000000000000000000000000000000000000000000000
e3e3e3e355555555e30444400044440044444444ffffffff00000000ffffffff0000000000000000000000000000000000000000000000000000000000000000
3e3e3e3e55555555304444444444444444444444f77ff77f00000000f77ff77f0000000000000000000000000000000000000000000000000000000000000000
e3e3e3e355555555044444444444444444444444f77ff77f00000000f77ff77f0000000000000000000000000000000000000000000000000000000000000000
3e3e3e3e55555555444444444444444444444444ffffffff00000000ffffffff0000000000000000000000000000000000000000000000000000000000000000
7e7e7e7e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e7e7e7e7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7e7e7e7e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e7e7e7e7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7e7e7e7e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e7e7e7e7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
7e7e7e7e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e7e7e7e7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9cccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9ccc9cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9cc9cc9cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc9cc9c99cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0cccccccccccccccccccc99c9c9ccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc000ccccccccccccccccccccc9c9ccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000ccccccccccccccccccccc9c9cc9cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccc00cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccc0000cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccc000000cccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccc0000000ccccc0000ccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccc00000000cccccc0000ccccc0ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccc0000000cccccccc0000ccc000ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccc0cc00000cccccccccc0000c00000ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccc000cc0000ccccccccccc0000000000ccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccc0000cc0000c0ccccccccc000000000cccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccc0cc0000cc000000ccccccccc0000000cccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccc000cc0000cc000000ccccccccc00000cccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccc0000cc0000cc000000cccc0cccc000cccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccc0000cc0000cc00000cccc00cccc0cccccccccccccccccccccccc555555cccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc0cccc0000cc0000cc0000ccc0000ccccccccccccccccccccccccccccccc55cccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccc000cccc0000cc0000cc0000c000000ccccccccccccccccccccccccccccccc55cccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccc00000cccc0000cc0000cc0000000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccc0000000cccc0000cc0000cc000000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccc0000000ccccc0000cc0000cc0000000cccccccccccccccc9cccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccc0000000ccccccc0000cc000ccc00000ccccccccccccccccc999ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc000000ccccccccc0000cc000ccc000ccccccccccccccccccc999ccc9ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc00000cccccccccc0000c000cccc0cccccccccccccccccc99c999cc99ccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc00000c0cccccccc0000000ccccccccccccccccccccccccc9c999c9ccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccc0000000cccccccccc00000ccccccccccccccccccccccccc9c9999cccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccc0cccccccc0000000ccccccccccc000cccccccccccccccccccccccccc99999ccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccc000cccccccc0000000cccccccccccc0cccccc0cccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccc0000cccccccc000000cccc0ccccccccccccc000cccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccccccccc88888
ccccccccc0000cccccccc00000ccc000cccccccccccc0000cccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccccccc8888888
ccccccccc0000cccccccc00000c00000cccccccccc000000cccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccccc888899999
ccccccccc0000cccccccc00000000000cccccccc00000000cccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccccc8889999999
ccccccccc0000cccccccc0000000000cccccccc000000000cccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccccc88899999999
ccccccccc0000cccccccc00000000cccccccc00000000000cccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccc88899999aaaa
ccccccccc0000cccccccc000000ccccccccc000000cc0000cccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccccc889999aaaaaa
ccccccccc0000ccccc0cc0000ccccccccccc00000ccc0000cccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccc889999aaaaaaa
ccccccccc0000ccc000cc000cccccccccccc000ccc000000cccccccccccccccccccc5555555cccccccccccccccccccccccccccccccccccccccc88999aaaaaaaa
ccccccccc0000c00000cc0cccccccccccccc0cccc0000000cccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc889999aaaaaaaa
ccccccccc0000000000ccccccccccccccccccccc000000cccccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc000000000cccccccccccccccccccccc0000cccccccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc0000000ccccccccccccccccccccccc0000ccccccccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc00000cccccccccccccccccccccccc0000cccccc0ccccccccccccccccccc5555555ccccccccccccccccccccccccccccccccccccccc88999aaaaaaaaa
ccccccccc000cccccccccccccccccccccccccc000ccccc000ccccccccccccccccccccc555ccccccccccccccccccccccccccccccccccccccccc889999aaaaaaaa
ccccccccc0ccccccccccccccccccccccccccc0000ccc00000ccccccccccccccccccccc555ccccccccccccccccccccccccccccccccccccccccc889999aaaaaaaa
ccccccccccccccccccccccccccccccccccccc0000cc000000ccccccccccccccccccccc555cccccccccccccccccccccccccccccccccccccccccc889999aaaaaaa
ccccccccccccccccccccccccccccccccccccc00000000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc8899999aaaaaa
ccccccccccccccccccccccccccccccccccccc000000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc88999999aaaa
ccccccccccccccccccccccccccccccccccccc00000000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc888999999999
ccccccccccccccccccccccccccccccccccccc000000cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc88899999999
ccccccccccccccccccccccccccccccccccccc0000ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc8889999999
ccccccccccccccccccccccccccccccccccccc000ccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaccccccccccccccccccccc888899999
ccccccccccccccccccccccccccccccccccccc0ccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaccccccccccccccccccccc8888888
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaacccccccccccccccccccccc88888
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaaacccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaaaaccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaacccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaacccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaacccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccccccccccccccccccccc00000000000ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaaaaccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaaacccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccaaaccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccaaacccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
ccccccccccccccccccccccccccccccccccccccccccccccccaaaaaccccccccccccccccccccccccccccccccccccccccccccccccccc0fffffffff0ccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccaaaccccccccccccccccccccccccccccccccccccc0000000000ccccc0fffffffff0ccccccccccccc
cccccccccccc00000000000ccccccccccccccccccccc0000ccccccccccccccccccccccccccccccccccccccccc0ffffffff0ccccc0fffffffff0ccccccccccccc
ccccccccc0000444444444400cccccccccccccccccc0044000ccccccccccccccccccccccccccccccccccccccc0ffffffff0ccccc0fffffffff0ccccccccccccc
ccccccc00044444444444444000cccccccccccccc00044444000ccccccccccccccccccccccccccccccccccccc0ffffffff0ccccc0fffffffff0ccccccccccccc
cccccc0044444444444444444440ccccccccc00000444444444000ccccccccccccccccccccccc000000ccccc00ffffffff0ccccc0fffffffff0ccccccccccccc
cccc000444444444444444444444000000c0004444444444444440000cccccccccccccccccc000444400000000ffffffff0ccccc0fffffffff0cccc000000ccc
cc00044444444444444444444440555555044444444444444444444400ccccccccccccccc00444444444444440ffffffff0ccccc0fffffffff0cccc0ffff0ccc
00044444444444444444444444005500055044444444444444444444400000ccccccccc0004444444444444440ffffffff0ccccc0fffffffff0cccc0ffff0ccc
0444444444444444444444440050500900504444444444444444444444444400cccccc00444444444444444440ffffffff0ccccc0fffffffff0cccc0ffff0ccc
444444444444444444444440555050999050444444444444444444444444444000000044444444444444444440ffffffff00cccc0fffffffff0cccc0ffff0ccc
444444444444444400000005555000099050000000000000004444444444444444444444444444444444444440ffffffff040ccc0fffffffff0cccc0ffff0ccc
444444444444440003333055555505099950333333333333300000000000044444444444444444444444444440ffffffff0440cc0fffffffff0cccc0ffff0ccc
444444444444000333330555555500500055033333333333333333333333304444444444444444444444444440ffffffff04440c0fffffffff0cccc0ffff0ccc
444444444440033333005555555550055555033300000000000000000000000444444444444444444444444440ffffffff04440c0fffffffff0cccc0ffff0ccc
444444444000000000555555555550005000000003333333333333333333330444444444444444444444444440ffffffff0444400fffffffff0cccc0ffff0ccc
444444444033333305555555555555000333333330333333330000000000033044444444444444444444444440ffffffff0444440fffffffff0cccc0ffff0ccc
000000000033333055555555555555503333333330333300007777777777703300000000000000000000000000ffffffff0000000fffffffff00000000000000
666666666033330555555555555555503333333333033330777777777777770306666666666666666666666660ffffffff0666660fffffffff06666666666666
666666666033005555555555555555033000000033303330777777777777777030666666666666666666666660ffffffff0666660fffffffff06666666666666
666666666030555555555555555500330077777003330333077777777777777703066666666666666666666660ffffffff0666660fffffffff06666666666666
66666666600555555555555555503333307777770033033307777777777777700030666666666666666666666000000000066666000000000006666666666666
66666666605555555555555555033333307777777033303330777777770000033330666666666666666666666666666666666666666666666666666666666666
66666666600555555555555500333333300000000000330330777000003333333330066666666666666666666666666666666666666666666666666666666666
66666666600555555555555033333333303333333330033033000333330000000000066666666666666666666666666666666666666666666666666666666666
66666666603055555555550333333333303333333333003033330000003333333077066666666666666666666666666666666666666666666666666666666666
66666666603055555555003333333333003333333333300300003333333333333077066666666666666666666666666666666666666666666666666666666666
66666666603305555550333333333333033333333333330303333333333333333077066666666666666666666666666666666666666666666666666666666666
66666666603300000003333333333333033333333333330303300003333333333000066666666666666666666666666666666666666666666666666666666666
66666666603333333333333333333333033333333333330303307703333333333333066666666666666666666666666666666666666666666666666666666666
66666666603333333333333333333333033333333333330303307703333333333333066666666666666666666666666666666666666666666666666666666666
66666666603333333333333333333333033333333333330303307703333333333333066666666666666666666666666666666666666666666666666666666666
66666666603330000003333333333333000000000000330303300003333333333333066666666666666666666666666666666666666666666666666666666666
66666666600000555500333333333333333333333330000303333333333333333333066666666666666666666666666666666666666666666666666666666666
66666666666605555550033333333333333333333333333303333333333333333333066666666666666666666666666666666666666666666666666666666666
00000000000055555555033333333333333330000000333303333333333333333333066660000000000000000000000000000000000000000000000000000000
66666666666050000555033333333333333000555550033303333333333333333333066666666666666666666666666666666666666666666666666666666666
66666666666050080055000033333333333055555555003303333333333333333333066666666666666666666666666666666666666666666666666666666666
66666666666055088055066600003333330055555555503303333333333333333000066666666666666666666666666666666666666666666666666666666666
66666666666055008055066666660000330555555555503303333333333333300006666666666666666666666666666666666666666666666666666666666666
66666666666005500055066666666666000555000055500303333333333330005006666666666666666666666666666666666666666666666666666666666666
66666666666600500555066666666666660555088005550303333333333300855066666666666666666666666666666666666666666666666666666666666666
66666666666660555500066666666666660550888805550003333333330008550066666666666666666666666666666666666666666666666666666666666666
66666666666660500006666666666666660050888805550600000000000055550666666666666666666666666666666666666666666666666666666666666666
66666666666660006666666666666666666050888805550666666666666005500666666666666666666666666666666666666666666666666666666666666666

__map__
3030303030303030303030303030303000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030303030303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3030303030303030303030303030303000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2222232323232323222323232323232300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2424242424242424242424242424242400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2121212121212121212121212121212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2121212121212121212121212121212100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00060000085500e5501155004550005001c5000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
001000000000012550105500e5500c5500e55012550175501f5502255000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00002e61020610166101461010610086100561001610006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600
000500000000003050000500005001050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000700000111000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000700002215000000000002410000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000