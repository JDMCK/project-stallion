package ecs

import "base:runtime"
import "core:slice"
Archetype :: struct {
	component_mask:  ComponentMask,
	entities:        [dynamic]EntityId,
	components:      [dynamic]ComponentColumn,
	component_types: [dynamic]u32,
}


Arch_init :: proc() -> Archetype {
	component_mask := mask_init()
	return Archetype {
		component_mask = component_mask,
		entities = [dynamic]EntityId{},
		components = [dynamic]ComponentColumn{},
		component_types = [dynamic]u32{},
	}
}

Arch_build :: proc(components: ..u32) -> (a: Archetype, err: Error) {
	if slice.max(components) >= len(Component) {
		return Archetype{}, Error.NO_ASSOCIATED_COMPONENT
	}
	if len(components) == 0 {
		return Archetype{}, Error.NO_COMPONENTS
	}

	arch := Arch_init()
	mask := mask_build(..components)

	for c in components {
		type := component_map(Component(c))
		col, err := Col_init(size_of(type))

		if err != runtime.Allocator_Error.None {
			return Archetype{}, .COL_ALLOCATION_FAILED
		}

		append(&arch.components, col)
	}
	arch.component_mask = mask
	arch.component_types = mask_get_components(mask)

	return arch, Error.None
}

Arch_add_entity :: proc(arch: ^Archetype, entity: EntityId) -> int {
	append(&arch.entities, entity)
	return len(arch.entities) - 1
}

add_component :: proc(arch: ^Archetype, component: Component, data: rawptr) {
	component_index := -1
	for c, i in arch.component_types {
		if c == cast(u32)component {
			component_index = i
		}
	}

	Col_add_entry(&arch.components[component_index], data)
}

get_component :: proc(arch: ^Archetype, component: $T) -> ^[]T {

}
