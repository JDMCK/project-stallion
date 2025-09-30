package ecs


EntityBuilder :: struct {
	entity:         Id,
	component_mask: ComponentMask,
	components:     [dynamic]any,
}

create_entity :: proc(entity: Id) -> EntityBuilder {
	return EntityBuilder {
		entity = entity,
		component_mask = mask_init(),
		components = [dynamic]any{},
	}
}

add_component :: proc(eb: ^EntityBuilder, component: Component, args: ..any) -> ^EntityBuilder {
	mask_add(&eb.component_mask, component)
	constructor := get_component_constructor(component)
	built_component := constructor(args)
	append(&eb.components, built_component)
	return eb
}
