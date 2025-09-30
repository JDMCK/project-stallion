package ecs

import "core:slice"
Archetype :: struct {
	component_mask: ComponentMask,
	entities:       [dynamic]u32,
	components:     [dynamic]ComponentColumn,
}


Arch_init :: proc() -> Archetype {
	return Archetype {
		component_mask = mask_init(),
		entities = [dynamic]EntityId{},
		components = [dynamic]ComponentColumn{},
	}
}

Arch_build :: proc(components: ..u32) -> (Archetype, Error) {
	if slice.max(components) >= len(Component) {
		return Archetype{}, Error.NO_ASSOCIATED_COMPONENT
	}
	if len(components) == 0 {
		return Archetype{}, Error.NO_COMPONENTS
	}

	arch := Arch_init()
	mask := mask_build(..components)
	arch.component_mask = mask
	return arch, Error.None
}

Arch_add_entity :: proc(arch: ^Archetype, entity: EntityId) {
	append(&arch.entities, entity)
	for c in mask_get_components(arch.component_mask) {
	}
}
