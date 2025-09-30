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

Col_add_entry :: proc(col: ^ComponentColumn, data: rawptr) -> runtime.Allocator_Error {
	if col.len >= col.capacity {
		new_buffer := mem.alloc(col.component_size * col.capacity * 2) or_return
		mem.copy(new_buffer, col.components, col.len)
		free(col.components)
		col.components = new_buffer
	}
	dest := col.components + (col.len * col.component_size)
	mem.copy(dest, data, col.component_size)
	col.len += 1
}

Col_remove_entry :: proc(col: ^ComponentColumn, index: int) {
	index := mem.ptr_offset(col.components, (index * col.component_size))
	last_element := ^u8(col.components) + ((col.len - 1) * col.component_size)
	mem.copy(index, last_element, col.component_size)
	mem.zero(last_element, col.component_size)
}
