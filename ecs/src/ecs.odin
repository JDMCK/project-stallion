package ecs

import "base:runtime"
import "core:fmt"
import "core:slice"

Entity :: struct {
	id:       u32,
	is_alive: bool,
}
ECS :: struct {
	next_entity_id: u32,
	archetypes:     [dynamic]Archetype,
	registry:       ^ComponentRegistry,
}

ECS_start :: proc(reg: ^ComponentRegistry) -> ECS {
	return ECS{registry = reg}
}

ECS_update :: proc(ecs: ^ECS) {
	remove_entities(ecs)
	free_all(context.temp_allocator)
}

build_entity_helper :: proc(ecs: ^ECS, components: ..runtime.Raw_Any) -> Entity {
	entity := Entity {
		id       = ecs.next_entity_id,
		is_alive = true,
	}
	ecs.next_entity_id += 1

	mask: ComponentMask
	for c in components {
		mask_add(&mask, ecs.registry, c)
	}

	// Sort components so archetypes can add them in order.
	context.user_ptr = &ecs.registry.type_to_index
	slice.sort_by(components, proc(i, j: runtime.Raw_Any) -> bool {
		reg := cast(^map[typeid]int)context.user_ptr
		return reg[i.id] < reg[j.id]
	})

	// Attempt to find an existing matching archetype...
	for &a in ecs.archetypes {
		if mask_equal(a.component_mask, mask) {
			Arch_add_entity(&a, ecs.registry, entity, ..components)
			return entity
		}
	}
	// otherwise, create it.
	new_arch := Arch_build(mask, ..components)
	Arch_add_entity(&new_arch, ecs.registry, entity, ..components)

	append(&ecs.archetypes, new_arch)
	return entity
}

build_entity :: proc(ecs: ^ECS, components: ..any) -> Entity {
	raw_components: [dynamic]runtime.Raw_Any
	for c in components {
		append(&raw_components, runtime.Raw_Any{data = c.data, id = c.id})
	}
	return build_entity_helper(ecs, ..raw_components[:])
}

remove_entities :: proc(ecs: ^ECS) {
	for &a in ecs.archetypes {
		for i := len(a.entities) - 1; i >= 0; i -= 1 {
			if !a.entities[i].is_alive {
				Arch_remove_entity(&a, i)
			}
		}
	}
}

query :: proc(ecs: ^ECS, components: ..typeid) -> [dynamic]Archetype {
	assert(len(components) != 0)

	archetypes := make([dynamic]Archetype, 0, context.temp_allocator)

	mask := mask_build(ecs.registry, ..components)
	for a in ecs.archetypes {
		if mask_match(mask, a.component_mask) {
			append(&archetypes, a)
		}
	}
	return len(archetypes) == 0 ? nil : archetypes
}
