package tests

import ecs "../src"
import "core:fmt"
import "core:mem"
import "core:testing"

@(test)
Col_add_entry :: proc(t: ^testing.T) {
	col: ecs.ComponentColumn
	col.len = 0
	col.capacity = 2
	col.component_size = size_of(int)
	col.components, _ = mem.alloc(col.capacity * col.component_size)

	defer ecs.Col_destroy(&col)

	expected := [?]int{10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 140, 140, 150, 160, 170}

	for i in 0 ..< 17 {
		ecs.Col_add_entry(&col, &expected[i])
	}

	testing.expect_value(t, col.len, 17)
	value := cast(^[17]int)col.components
	ok := slice_equals(int, value[:], expected[:])

	testing.expect(t, ok)
}

@(test)
Col_remove_entry :: proc(t: ^testing.T) {
	col: ecs.ComponentColumn
	col.len = 0
	col.capacity = 5
	col.component_size = size_of(int)
	col.components, _ = mem.alloc(col.capacity * col.component_size)

	defer ecs.Col_destroy(&col)

	values: [5]int = [5]int{10, 20, 30, 40, 50}
	for i in 0 ..< 5 {
		ecs.Col_add_entry(&col, &values[i])
	}

	// Remove element at index 2 (value 30)
	ecs.Col_remove_entry(&col, 2)

	testing.expect_value(t, col.len, 4)

	// Expected result: 10, 20, 50, 40 (last element moved to removed spot)
	expected := [4]int{10, 20, 50, 40}
	value := cast(^[4]int)col.components
	ok := slice_equals(int, value[:], expected[:])

	testing.expect(t, ok)
}
