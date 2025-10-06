package game

import "base:runtime"
import "core:fmt"
import "core:reflect"

TEST :: enum {
	Position,
	Velocity,
	Health,
}

Position :: struct {
	x: f64,
	y: f64,
}

Velocity :: struct {
	x: f64,
	y: f64,
}

Health :: struct {
	value: u32,
}

build_entity :: proc(components: ..runtime.Raw_Any) {
	for c in components {
		fmt.println(c.id)
	}
}

c :: proc(data: $T) -> runtime.Raw_Any {
	return runtime.Raw_Any{data = data, id = typeid_of(T)}
}

main :: proc() {
	// build_entity(c(&Position{x = 1, y = 2}), c(&Health{value = 4}))
	// fmt.println(size_of(Health{value = 3}))
	health := Health {
		value = 1,
	}
	raw_health := cast(rawptr)&health
	fmt.println(cast([^]Health)raw_health)


}
