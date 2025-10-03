package ecs

import "base:runtime"
import "core:mem"

Initial_Size :: 16

/*
A component column contains a contiguous array of structs
*/
ComponentColumn :: struct {
	components:     rawptr, // buffer with component data
	component_size: int, // size of a single component
	capacity:       int, // size of underlying array
	len:            int, // quantity of items
}

Col_init :: proc(component_size: int) -> (col: ComponentColumn, err: runtime.Allocator_Error) {
	components := mem.alloc(component_size * Initial_Size) or_return
	return ComponentColumn {
			components = components,
			component_size = component_size,
			capacity = Initial_Size,
			len = 0,
		},
		runtime.Allocator_Error.None
}

Col_destroy :: proc(col: ^ComponentColumn) {
	mem.free(col.components)
}

Col_add_entry :: proc(col: ^ComponentColumn, data: rawptr) -> runtime.Allocator_Error {
	if col.len >= col.capacity {
		new_buffer := mem.alloc(col.component_size * col.capacity * 2) or_return
		mem.copy(new_buffer, col.components, col.len * col.component_size)
		mem.free(col.components)
		col.components = new_buffer
		col.capacity *= 2
	}
	raw_components := cast(uintptr)col.components

	dest := raw_components + cast(uintptr)(col.len * col.component_size)
	raw_dest := cast(rawptr)dest
	mem.copy(raw_dest, data, col.component_size)
	col.len += 1

	return .None
}

Col_remove_entry :: proc(col: ^ComponentColumn, index: int) {
	raw_components := cast(uintptr)col.components
	index := raw_components + cast(uintptr)(index * col.component_size)
	raw_index := cast(rawptr)index
	last_index := raw_components + cast(uintptr)((col.len - 1) * col.component_size)
	raw_last_index := cast(rawptr)last_index

	mem.copy(raw_index, raw_last_index, col.component_size)
	mem.zero(raw_last_index, col.component_size)
	col.len -= 1
}

Col_get_entry :: proc(col: ^ComponentColumn, index: int) -> rawptr {
	raw_components := cast(uintptr)col.components
	return cast(rawptr)(raw_components + cast(uintptr)(index * col.component_size))
}
