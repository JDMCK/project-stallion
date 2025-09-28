package ecs

import "core:slice"

Id :: u32
EntityManager :: struct {
	entities:      [dynamic]Id,
	next_entity:   Id,
	removal_queue: [dynamic]Id,
}

EM_init :: proc() -> EntityManager {
	return EntityManager{entities = [dynamic]Id{}, next_entity = 0}
}

EM_destroy :: proc(em: ^EntityManager) {
	delete(em.entities)
	delete(em.removal_queue)
}

EM_create_entity :: proc(em: ^EntityManager) -> Id {
	id := em.next_entity
	append(&em.entities, id)
	em.next_entity += 1
	return id
}

EM_queue_remove_entity :: proc(em: ^EntityManager, id: Id) {
	if !slice.contains(em.removal_queue[:], id) {
		append(&em.removal_queue, id)
	}
}

EM_remove_entities :: proc(em: ^EntityManager) {
	next_entities := [dynamic]u32{}
	entities_loop: for id_1 in em.entities {
		for id_2 in em.removal_queue {
			if id_1 == id_2 {
				continue entities_loop
			}
		}
		append(&next_entities, id_1)
	}
	delete(em.entities)

	em.entities = next_entities
}

EM_clear_entities :: proc(em: ^EntityManager) {
	clear(&em.removal_queue)
	clear(&em.entities)
}
