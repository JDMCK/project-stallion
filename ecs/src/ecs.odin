package ecs

import "base:runtime"
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
	// TODO: go through all archetypes and remove dead entities
	free_all(context.temp_allocator)
}

// helper to convert components to runtime.Raw_Any
c :: proc(data: ^$T) -> runtime.Raw_Any {
	return runtime.Raw_Any{data = data, id = typeid_of(T)}
}

build_entity :: proc(ecs: ^ECS, components: ..runtime.Raw_Any) -> Entity {
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

remove_entities :: proc(ecs: ^ECS) {}

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
