package game

import ecs "../ecs/src"
import rl "vendor:raylib"

Position :: distinct rl.Vector2

Velocity :: distinct rl.Vector2

Sprite :: struct {
	width:   f32,
	height:  f32,
	texture: rl.Texture2D,
}

register_all_components :: proc(reg: ^ecs.ComponentRegistry) {
	ecs.register_components(reg, Position, Velocity, Sprite)
}
