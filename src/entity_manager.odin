package ecs

import "core:slice"

EntityId :: u32
EntityManager :: struct {
	next_entity:   EntityId,
	removal_queue: [dynamic]EntityId,
	archetypes:    [dynamic]Archetype,
}

EM_init :: proc() -> EntityManager {
	return EntityManager{}
}

add_entity :: proc(em: ^EntityManager, mask: ComponentMask) -> (a: Archetype, err: Error) {
	for &a in em.archetypes {
		if mask_equal(a.component_mask, mask) {
			Arch_add_entity(&a, em.next_entity)
			return a, Error.None
		}
	}
	// otherwise, create it
	arch := Arch_build(..mask_get_components(mask)[:]) or_return
	Arch_add_entity(&arch, em.next_entity)
	em.next_entity += 1
	return arch, Error.None
}
