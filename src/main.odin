package game

import ecs "../ecs/src"
import "base:runtime"
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

main :: proc() {
	using ecs

	rl.SetConfigFlags(rl.ConfigFlags{rl.ConfigFlag.WINDOW_RESIZABLE})
	rl.InitWindow(1920, 1080, "ECS")
	rl.SetTargetFPS(60)

	reg: ComponentRegistry
	register_all_components(&reg)
	ecs := ECS_start(&reg)

	camera := rl.Camera2D{}
	camera.offset = cast(rl.Vector2){
		cast(f32)rl.GetScreenWidth() / 2,
		cast(f32)rl.GetScreenHeight() / 2,
	}
	camera.zoom = 5

	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.SKYBLUE)
		rl.BeginMode2D(camera)
		{ 	// game code goes here

		}

		rl.EndMode2D()
		rl.DrawFPS(10, 10)
		rl.EndDrawing()

		ECS_update(&ecs)
	}
}
