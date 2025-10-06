package ecs


ComponentRegistry :: struct {
	next_component_index: u32,
	type_to_index:        map[typeid]u32,
}

// This allows bitmasks to be created for efficient archetype querying
register_components :: proc(cr: ^ComponentRegistry, types: ..typeid) {
	for t in types {
		new_index := cr.next_component_index
		cr.type_to_index[t] = new_index

		cr.next_component_index += 1
	}
}
