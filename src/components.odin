package game

import ecs "../ecs/src"
import rl "vendor:raylib"

Position :: distinct rl.Vector2

Velocity :: distinct rl.Vector2

DrawableCircle :: struct {
	radius:       f32,
	color:        rl.Color,
	border_color: rl.Color,
}

register_all_components :: proc(reg: ^ecs.ComponentRegistry) {
	ecs.register_components(reg, Position, Velocity, DrawableCircle)
}
