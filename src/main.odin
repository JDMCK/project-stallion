package game

import ecs "../ecs/src"
import "base:runtime"
import "core:fmt"
import "core:math/rand"
import rl "vendor:raylib"

main :: proc() {
	using ecs

	rl.InitWindow(800, 800, "ECS")
	rl.SetTargetFPS(60)

	reg: ComponentRegistry
	register_all_components(&reg)
	ecs := ECS_start(&reg)

	texture := rl.LoadTexture("src\\cactus.png")
	for i in 0 ..< 100 {
		random_1 := rand.float32()
		random_2 := rand.float32()
		build_entity(
			&ecs,
			Position{random_1, random_2},
			Velocity{random_2 * 10, random_1 * 10},
			Sprite{width = 5.0, height = 5.0, texture = texture},
		)
	}

	remove_index := 0
	context.user_ptr = &remove_index
	for !rl.WindowShouldClose() {
		rl.BeginDrawing()
		rl.ClearBackground(rl.PINK)
		// game code goes here
		{
			r := query(&ecs, Position, Velocity)
			for_each(r, proc(p: ^Position, v: ^Velocity, e: ^Entity) {
				p[0] += v[0]
				p[1] += v[1]

				if p[0] < 0 || p[0] > cast(f32)rl.GetScreenWidth() {
					v[0] *= -1
				}
				if p[1] < 0 || p[1] > cast(f32)rl.GetScreenHeight() {
					v[1] *= -1
				}
			})

			r = query(&ecs, Position, Sprite)
			for_each(r, proc(p: ^Position, s: ^Sprite, e: ^Entity) {
				rl.DrawTextureV(s.texture, cast(rl.Vector2)p^, rl.WHITE)
			})
			rl.DrawFPS(10, 40)
		}

		rl.EndDrawing()

		ECS_update(&ecs)
	}
}
