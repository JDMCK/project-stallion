package ecs

Component :: enum u32 {
	Test,
}

Test :: struct {
	x: f64,
	y: f64,
}

component_map :: proc(component: Component) -> typeid {
	switch component {
	case .Test:
		return Test
	case:
		return nil
	}
}
