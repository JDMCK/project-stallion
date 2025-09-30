package ecs

Component :: enum u32 {}

get_component_constructor :: proc(component: Component) -> proc(args: ..any) -> any {
	switch component {
	case:
		return proc(args: ..any) -> any {return nil}
	}
}
