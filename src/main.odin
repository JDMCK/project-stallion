package game

import ecs "../ecs/src"
import "base:runtime"
import "core:fmt"
import rl "vendor:raylib"

Test :: struct {
	name: string,
	age:  u32,
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

main :: proc() {
	using ecs

	rl.InitWindow(800, 800, "ECS")
	rl.SetTargetFPS(60)

	reg: ComponentRegistry
	register_components(&reg, Position, Velocity, Health)
	ecs := ECS_start(&reg)

	entity_1 := build_entity(&ecs, c(&Position{x = 1, y = 1}), c(&Health{value = 1}))
	entity_2 := build_entity(&ecs, c(&Position{x = 2, y = 2}), c(&Health{value = 2}))
	entity_3 := build_entity(&ecs, c(&Position{x = 3, y = 3}), c(&Health{value = 3}))

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.PINK)
		{ 	// game code goes here
			a := query(&ecs, Position, Health)
			for_each(a, proc(h: ^Health) {
				h.value += 1
			})
			for_each(a, proc(c: ^Health) {
				fmt.println(c.value)
			})
		}
		rl.EndDrawing()
	}
}
