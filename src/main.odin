package ecs

import "core:fmt"
import rl "vendor:raylib"

main :: proc() {
	rl.InitWindow(800, 800, "ECS")
	rl.SetTargetFPS(60)

	em := EM_init()
	arch, _ := add_entity(&em, mask_build(Component.Test))
	add_component(&arch, .Test, &Test{x = 1, y = 2})


	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.PINK)
		rl.EndDrawing()
	}
}
