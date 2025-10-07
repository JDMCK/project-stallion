package ecs

import "base:runtime"
import "core:fmt"
import "core:slice"

Archetype :: struct {
	component_mask:  ComponentMask,
	entities:        [dynamic]Entity,
	components:      [dynamic]ComponentColumn,
	component_types: [dynamic]typeid,
}


Arch_init :: proc() -> Archetype {
	component_mask := mask_init()
	return Archetype {
		component_mask = component_mask,
		entities = [dynamic]Entity{},
		components = [dynamic]ComponentColumn{},
		component_types = [dynamic]typeid{},
	}
}

Arch_build :: proc(mask: ComponentMask, components: ..runtime.Raw_Any) -> Archetype {
	assert(len(components) > 0)
	assert(cast(int)mask.component_count == len(components))

	arch := Arch_init()
	arch.component_mask = mask

	for c in components {
		append(&arch.component_types, c.id)
		col := Col_init(type_info_of(c.id).size)
		append(&arch.components, col)
	}

	return arch
}

Arch_add_entity :: proc(
	arch: ^Archetype,
	reg: ^ComponentRegistry,
	entity: Entity,
	sorted_components: ..runtime.Raw_Any,
) {
	// Ensure sorted_components really is sorted.
	context.user_ptr = &reg.type_to_index
	assert(slice.is_sorted_by(sorted_components, proc(i, j: runtime.Raw_Any) -> bool {
			reg := cast(^map[typeid]int)context.user_ptr
			return reg[i.id] < reg[j.id]}))

	append(&arch.entities, entity)
	for c, i in sorted_components {
		Col_add_entry(&arch.components[i], sorted_components[i].data)
	}
}

Arch_remove_entity :: proc(arch: ^Archetype, entity_index: int) {
	for &col in arch.components {
		Col_remove_entry(&col, entity_index)
	}
	unordered_remove(&arch.entities, entity_index)
}
