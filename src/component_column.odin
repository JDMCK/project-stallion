package ecs

import "base:runtime"
import "core:fmt"
import "core:mem"

Initial_Capacity :: 16

/*
A component column contains a contiguous array of structs
*/
ComponentColumn :: struct {
	data:           rawptr, // buffer with component data
	component_size: int, // size of a single component
	capacity:       int, // size of underlying array
	len:            int, // quantity of items
}

Col_init :: proc(component_size: int) -> ComponentColumn {
	space, err := mem.alloc(component_size * Initial_Capacity)

	if err != runtime.Allocator_Error.None {
		fmt.println("Failed to allocate Component Column:", err)
		return ComponentColumn{}
	}

	return ComponentColumn {
		data = space,
		component_size = component_size,
		capacity = Initial_Capacity,
		len = 0,
	}
}

Col_destroy :: proc(col: ^ComponentColumn) {
	mem.free(col.data)
}

Col_add_entry :: proc(col: ^ComponentColumn, data: rawptr) {
	if col.len >= col.capacity {
		new_buffer, err := mem.alloc(col.component_size * col.capacity * 2)

		if err != runtime.Allocator_Error.None {
			fmt.println("Failed to allocate Component Column:", err)
			return
		}

		mem.copy(new_buffer, col.data, col.len * col.component_size)
		mem.free(col.data)
		col.data = new_buffer
		col.capacity *= 2
	}
	raw_components := cast(uintptr)col.data

	dest := raw_components + cast(uintptr)(col.len * col.component_size)
	raw_dest := cast(rawptr)dest
	mem.copy(raw_dest, data, col.component_size)
	col.len += 1
}

Col_remove_entry :: proc(col: ^ComponentColumn, index: int) {
	raw_components := cast(uintptr)col.data
	index := raw_components + cast(uintptr)(index * col.component_size)
	raw_index := cast(rawptr)index
	last_index := raw_components + cast(uintptr)((col.len - 1) * col.component_size)
	raw_last_index := cast(rawptr)last_index

	mem.copy(raw_index, raw_last_index, col.component_size)
	mem.zero(raw_last_index, col.component_size)
	col.len -= 1
}

Col_get_entry :: proc(col: ^ComponentColumn, index: int) -> rawptr {
	raw_components := cast(uintptr)col.data
	return cast(rawptr)(raw_components + cast(uintptr)(index * col.component_size))
}
