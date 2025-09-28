package tests

import ecs "../src"
import "core:fmt"
import "core:log"
import "core:testing"

@(test)
create_entities :: proc(t: ^testing.T) {
	em := ecs.EM_init()
	defer ecs.EM_destroy(&em)

	for i in 0 ..< 5 {
		ecs.EM_create_entity(&em)
	}
	ecs.EM_queue_remove_entity(&em, 2)
	ecs.EM_create_entity(&em)
	ecs.EM_remove_entities(&em)
	ecs.EM_queue_remove_entity(&em, 3)

	ok := slice_equals(u32, em.entities[:], []u32{0, 1, 3, 4, 5})

	testing.expect(t, ok, "Entities added properly.")
}

@(test)
remove_entities :: proc(t: ^testing.T) {
	em := ecs.EM_init()
	defer ecs.EM_destroy(&em)

	for i in 0 ..< 5 {
		ecs.EM_create_entity(&em)
	}

	ok: bool
	ecs.EM_remove_entities(&em)
	ok = slice_equals(u32, em.entities[:], []u32{0, 1, 2, 3, 4})
	testing.expect(t, ok, "Removing entities before queueing does nothing.")

	ecs.EM_queue_remove_entity(&em, 0)
	ecs.EM_queue_remove_entity(&em, 2)
	ecs.EM_queue_remove_entity(&em, 4)
	ecs.EM_queue_remove_entity(&em, 6)

	ecs.EM_remove_entities(&em)

	ok = slice_equals(u32, em.entities[:], []u32{1, 3})
	testing.expect(t, ok, "Removed queued entities.")
}

@(test)
clear_entities :: proc(t: ^testing.T) {
	em := ecs.EM_init()
	defer ecs.EM_destroy(&em)

	for i in 0 ..< 5 {
		ecs.EM_create_entity(&em)
	}
	ecs.EM_clear_entities(&em)

	ok := slice_equals(u32, em.entities[:], []u32{})

	testing.expect(t, ok, "All entitites cleared.")
}
