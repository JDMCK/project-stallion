package game

import "core:fmt"
import "core:reflect"

TEST :: enum u32 {
	hi,
	hello,
}

test_init :: proc(num: u32) {
	fmt.println(num)
}


main :: proc() {
	test_init(.hi)
}
