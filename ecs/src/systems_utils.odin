package ecs

// 1 components
get_components_1 :: proc(archetype: Archetype, component: $A) -> ([]A, [dynamic]Entity) {
	type_a := typeid_of(A)
	idx_a: int = -1
	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data

	return ptr_a[:len(archetype.entities)], archetype.entities
}

// 2 components
get_components_2 :: proc(archetype: Archetype, a: $A, b: $B) -> ([]A, []B, [dynamic]Entity) {
	type_a := typeid_of(A)
	type_b := typeid_of(B)
	idx_a, idx_b: int = -1, -1

	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
		if ct == type_b {idx_b = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data
	ptr_b := cast([^]B)archetype.components[idx_b].data

	return ptr_a[:len(archetype.entities)], ptr_b[:len(archetype.entities)], archetype.entities
}

// 3 components
get_components_3 :: proc(
	archetype: Archetype,
	a: $A,
	b: $B,
	c: $C,
) -> (
	[]A,
	[]B,
	[]C,
	[dynamic]Entity,
) {
	type_a := typeid_of(A)
	type_b := typeid_of(B)
	type_c := typeid_of(C)
	idx_a, idx_b, idx_c: int = -1, -1, -1

	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
		if ct == type_b {idx_b = i}
		if ct == type_c {idx_c = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data
	ptr_b := cast([^]B)archetype.components[idx_b].data
	ptr_c := cast([^]C)archetype.components[idx_c].data

	return ptr_a[:len(archetype.entities)],
		ptr_b[:len(archetype.entities)],
		ptr_c[:len(archetype.entities)],
		archetype.entities
}

// 4 components
get_components_4 :: proc(
	archetype: Archetype,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
) -> (
	[]A,
	[]B,
	[]C,
	[]D,
	[dynamic]Entity,
) {
	type_a := typeid_of(A)
	type_b := typeid_of(B)
	type_c := typeid_of(C)
	type_d := typeid_of(D)
	idx_a, idx_b, idx_c, idx_d: int = -1, -1, -1, -1

	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
		if ct == type_b {idx_b = i}
		if ct == type_c {idx_c = i}
		if ct == type_d {idx_d = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data
	ptr_b := cast([^]B)archetype.components[idx_b].data
	ptr_c := cast([^]C)archetype.components[idx_c].data
	ptr_d := cast([^]D)archetype.components[idx_d].data

	return ptr_a[:len(archetype.entities)],
		ptr_b[:len(archetype.entities)],
		ptr_c[:len(archetype.entities)],
		ptr_d[:len(archetype.entities)],
		archetype.entities
}

// 5 components
get_components_5 :: proc(
	archetype: Archetype,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
) -> (
	[]A,
	[]B,
	[]C,
	[]D,
	[]E,
	[dynamic]Entity,
) {
	type_a := typeid_of(A)
	type_b := typeid_of(B)
	type_c := typeid_of(C)
	type_d := typeid_of(D)
	type_e := typeid_of(E)
	idx_a, idx_b, idx_c, idx_d, idx_e: int = -1, -1, -1, -1, -1

	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
		if ct == type_b {idx_b = i}
		if ct == type_c {idx_c = i}
		if ct == type_d {idx_d = i}
		if ct == type_e {idx_e = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data
	ptr_b := cast([^]B)archetype.components[idx_b].data
	ptr_c := cast([^]C)archetype.components[idx_c].data
	ptr_d := cast([^]D)archetype.components[idx_d].data
	ptr_e := cast([^]E)archetype.components[idx_e].data

	return ptr_a[:len(archetype.entities)],
		ptr_b[:len(archetype.entities)],
		ptr_c[:len(archetype.entities)],
		ptr_d[:len(archetype.entities)],
		ptr_e[:len(archetype.entities)],
		archetype.entities
}

// 6 components
get_components_6 :: proc(
	archetype: Archetype,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
	f: $F,
) -> (
	[]A,
	[]B,
	[]C,
	[]D,
	[]E,
	[]F,
	[dynamic]Entity,
) {
	type_a := typeid_of(A)
	type_b := typeid_of(B)
	type_c := typeid_of(C)
	type_d := typeid_of(D)
	type_e := typeid_of(E)
	type_f := typeid_of(F)
	idx_a, idx_b, idx_c, idx_d, idx_e, idx_f: int = -1, -1, -1, -1, -1, -1

	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
		if ct == type_b {idx_b = i}
		if ct == type_c {idx_c = i}
		if ct == type_d {idx_d = i}
		if ct == type_e {idx_e = i}
		if ct == type_f {idx_f = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data
	ptr_b := cast([^]B)archetype.components[idx_b].data
	ptr_c := cast([^]C)archetype.components[idx_c].data
	ptr_d := cast([^]D)archetype.components[idx_d].data
	ptr_e := cast([^]E)archetype.components[idx_e].data
	ptr_f := cast([^]F)archetype.components[idx_f].data

	return ptr_a[:len(archetype.entities)],
		ptr_b[:len(archetype.entities)],
		ptr_c[:len(archetype.entities)],
		ptr_d[:len(archetype.entities)],
		ptr_e[:len(archetype.entities)],
		ptr_f[:len(archetype.entities)],
		archetype.entities
}

// 7 components
get_components_7 :: proc(
	archetype: Archetype,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
	f: $F,
	g: $G,
) -> (
	[]A,
	[]B,
	[]C,
	[]D,
	[]E,
	[]F,
	[]G,
	[dynamic]Entity,
) {
	type_a := typeid_of(A)
	type_b := typeid_of(B)
	type_c := typeid_of(C)
	type_d := typeid_of(D)
	type_e := typeid_of(E)
	type_f := typeid_of(F)
	type_g := typeid_of(G)
	idx_a, idx_b, idx_c, idx_d, idx_e, idx_f, idx_g: int = -1, -1, -1, -1, -1, -1, -1

	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
		if ct == type_b {idx_b = i}
		if ct == type_c {idx_c = i}
		if ct == type_d {idx_d = i}
		if ct == type_e {idx_e = i}
		if ct == type_f {idx_f = i}
		if ct == type_g {idx_g = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data
	ptr_b := cast([^]B)archetype.components[idx_b].data
	ptr_c := cast([^]C)archetype.components[idx_c].data
	ptr_d := cast([^]D)archetype.components[idx_d].data
	ptr_e := cast([^]E)archetype.components[idx_e].data
	ptr_f := cast([^]F)archetype.components[idx_f].data
	ptr_g := cast([^]G)archetype.components[idx_g].data

	return ptr_a[:len(archetype.entities)],
		ptr_b[:len(archetype.entities)],
		ptr_c[:len(archetype.entities)],
		ptr_d[:len(archetype.entities)],
		ptr_e[:len(archetype.entities)],
		ptr_f[:len(archetype.entities)],
		ptr_g[:len(archetype.entities)],
		archetype.entities
}

// 8 components
get_components_8 :: proc(
	archetype: Archetype,
	a: $A,
	b: $B,
	c: $C,
	d: $D,
	e: $E,
	f: $F,
	g: $G,
	h: $H,
) -> (
	[]A,
	[]B,
	[]C,
	[]D,
	[]E,
	[]F,
	[]G,
	[]H,
	[dynamic]Entity,
) {
	type_a := typeid_of(A)
	type_b := typeid_of(B)
	type_c := typeid_of(C)
	type_d := typeid_of(D)
	type_e := typeid_of(E)
	type_f := typeid_of(F)
	type_g := typeid_of(G)
	type_h := typeid_of(H)
	idx_a, idx_b, idx_c, idx_d, idx_e, idx_f, idx_g, idx_h: int = -1, -1, -1, -1, -1, -1, -1, -1

	for ct, i in archetype.component_types {
		if ct == type_a {idx_a = i}
		if ct == type_b {idx_b = i}
		if ct == type_c {idx_c = i}
		if ct == type_d {idx_d = i}
		if ct == type_e {idx_e = i}
		if ct == type_f {idx_f = i}
		if ct == type_g {idx_g = i}
		if ct == type_h {idx_h = i}
	}

	ptr_a := cast([^]A)archetype.components[idx_a].data
	ptr_b := cast([^]B)archetype.components[idx_b].data
	ptr_c := cast([^]C)archetype.components[idx_c].data
	ptr_d := cast([^]D)archetype.components[idx_d].data
	ptr_e := cast([^]E)archetype.components[idx_e].data
	ptr_f := cast([^]F)archetype.components[idx_f].data
	ptr_g := cast([^]G)archetype.components[idx_g].data
	ptr_h := cast([^]H)archetype.components[idx_h].data

	return ptr_a[:len(archetype.entities)],
		ptr_b[:len(archetype.entities)],
		ptr_c[:len(archetype.entities)],
		ptr_d[:len(archetype.entities)],
		ptr_e[:len(archetype.entities)],
		ptr_f[:len(archetype.entities)],
		ptr_g[:len(archetype.entities)],
		ptr_h[:len(archetype.entities)]
}


// 1 component
for_each_1 :: proc(archetypes: [dynamic]Archetype, f: proc(a: ^$A, ent: ^Entity)) {
	for arches in archetypes {
		ca, ent := get_components_1(arches, A{})
		for i in 0 ..< len(ca) {
			f(&ca[i], &ent[i])
		}
	}
}

// 2 components
for_each_2 :: proc(archetypes: [dynamic]Archetype, f: proc(a: ^$A, b: ^$B, ent: ^Entity)) {
	for arches in archetypes {
		ca, cb, ent := get_components_2(arches, A{}, B{})
		for i in 0 ..< len(ca) {
			f(&ca[i], &cb[i], &ent[i])
		}
	}
}

// 3 components
for_each_3 :: proc(archetypes: [dynamic]Archetype, f: proc(a: ^$A, b: ^$B, c: ^$C, ent: ^Entity)) {
	for arches in archetypes {
		ca, cb, cc, ent := get_components_3(arches, A{}, B{}, C{})
		for i in 0 ..< len(ca) {
			f(&ca[i], &cb[i], &cc[i], &ent[i])
		}
	}
}

// 4 components
for_each_4 :: proc(
	archetypes: [dynamic]Archetype,
	f: proc(a: ^$A, b: ^$B, c: ^$C, d: ^$D, ent: ^Entity),
) {
	for arches in archetypes {
		ca, cb, cc, cd, ent := get_components_4(arches, A{}, B{}, C{}, D{})
		for i in 0 ..< len(ca) {
			f(&ca[i], &cb[i], &cc[i], &cd[i], &ent[i])
		}
	}
}

// 5 components
for_each_5 :: proc(
	archetypes: [dynamic]Archetype,
	f: proc(a: ^$A, b: ^$B, c: ^$C, d: ^$D, e: ^$E, ent: ^Entity),
) {
	for arches in archetypes {
		ca, cb, cc, cd, ce, ent := get_components_5(arches, A{}, B{}, C{}, D{}, E{})
		for i in 0 ..< len(ca) {
			f(&ca[i], &cb[i], &cc[i], &cd[i], &ce[i], &ent[i])
		}
	}
}

// 6 components
for_each_6 :: proc(
	archetypes: [dynamic]Archetype,
	f: proc(a: ^$A, b: ^$B, c: ^$C, d: ^$D, e: ^$E, g: ^$F, ent: ^Entity),
) {
	for arches in archetypes {
		ca, cb, cc, cd, ce, cf, ent := get_components_6(arches, A{}, B{}, C{}, D{}, E{}, F{})
		for i in 0 ..< len(ca) {
			f(&ca[i], &cb[i], &cc[i], &cd[i], &ce[i], &cf[i], &ent[i])
		}
	}
}

// 7 components
for_each_7 :: proc(
	archetypes: [dynamic]Archetype,
	f: proc(a: ^$A, b: ^$B, c: ^$C, d: ^$D, e: ^$E, g: ^$F, h: ^$G, ent: ^Entity),
) {
	for arches in archetypes {
		ca, cb, cc, cd, ce, cf, cg, ent := get_components_7(
			arches,
			A{},
			B{},
			C{},
			D{},
			E{},
			F{},
			G{},
		)
		for i in 0 ..< len(ca) {
			f(&ca[i], &cb[i], &cc[i], &cd[i], &ce[i], &cf[i], &cg[i], &ent[i])
		}
	}
}

// 8 components
for_each_8 :: proc(
	archetypes: [dynamic]Archetype,
	f: proc(a: ^$A, b: ^$B, c: ^$C, d: ^$D, e: ^$E, g: ^$F, h: ^$G, i: ^$H, ent: ^Entity),
) {
	for arches in archetypes {
		ca, cb, cc, cd, ce, cf, cg, ch, ent := get_components_8(
			arches,
			A{},
			B{},
			C{},
			D{},
			E{},
			F{},
			G{},
			H{},
		)
		for i in 0 ..< len(ca) {
			f(&ca[i], &cb[i], &cc[i], &cd[i], &ce[i], &cf[i], &cg[i], &ch[i], &ent[i])
		}
	}
}


get_components :: proc {
	get_components_1,
	get_components_2,
	get_components_3,
	get_components_4,
	get_components_5,
	get_components_6,
	get_components_7,
	get_components_8,
}


for_each :: proc {
	for_each_1,
	for_each_2,
	for_each_3,
	for_each_4,
	for_each_5,
	for_each_6,
	for_each_7,
	for_each_8,
}
