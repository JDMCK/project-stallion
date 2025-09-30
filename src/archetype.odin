package ecs

import "core:slice"
Archetype :: struct {
	component_mask: ComponentMask,
	entities:       [dynamic]u32,
	components:     [dynamic]rawptr,
}

Arch_init :: proc() -> Archetype {
	return Archetype {
		component_mask = mask_init(),
		entities = [dynamic]Id{},
		components = [dynamic]rawptr{},
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
	component_mask := mask_build(..components)
	components := make([dynamic]rawptr, 0, len(components))
	arch.component_mask = component_mask
	arch.components = components
	return arch, Error.None
}

Arch_add_entity :: proc(arch: ^Archetype, entity: Id) {
	append(&arch.entities, entity)

}
