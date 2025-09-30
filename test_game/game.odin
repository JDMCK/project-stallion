package game

import "core:fmt"
import "core:reflect"

TEST :: enum u32 {
	hi,
	hello,
}

get_type :: proc() -> typeid {
	return typeid_of(u32)
}

type_foo :: proc(type: $T) -> [dynamic]T {
	return [dynamic]T{}
}

main :: proc() {
	type := get_type()
	array := type_foo(type)

	append(&array, u32(4))
	fmt.println(array)
}
