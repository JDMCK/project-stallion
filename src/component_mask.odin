package ecs

import "base:runtime"
import "core:fmt"
import "core:slice"

ComponentMask :: struct {
	words:           [dynamic]u64le,
	word_count:      u32,
	component_count: u32,
}

mask_init :: proc() -> ComponentMask {
	return ComponentMask{words = [dynamic]u64le{}}
}

mask_destroy :: proc(mask: ^ComponentMask) {
	delete(mask.words)
}

mask_add_u32 :: proc(mask: ^ComponentMask, values: ..u32) {
	// Increase word_count if necessary.
	max_value := slice.max(values)
	word_count := max_value / 64 + 1
	if mask.word_count < word_count {
		for _ in 0 ..< word_count - mask.word_count {
			append(&mask.words, 0)
		}
		mask.word_count = word_count
	}

	// Set bits.
	for v, i in values {
		word_index := v / 64
		word := u64le(1) << (v % 64)
		mask.words[word_index] |= word
		mask.component_count += 1
	}
}

mask_add_raw_any :: proc(
	mask: ^ComponentMask,
	registry: ^ComponentRegistry,
	values: ..runtime.Raw_Any,
) {
	for v in values {
		index := registry.type_to_index[v.id]
		mask_add_u32(mask, index)
	}
}

mask_add_typeid :: proc(mask: ^ComponentMask, registry: ^ComponentRegistry, values: ..typeid) {
	for v in values {
		index := registry.type_to_index[v]
		mask_add_u32(mask, index)
	}
}

mask_add :: proc {
	mask_add_u32,
	mask_add_raw_any,
}

mask_build_u32 :: proc(values: ..u32) -> ComponentMask {
	mask := mask_init()
	mask_add_u32(&mask, ..values)
	return mask
}

mask_build_raw_any :: proc(
	registry: ^ComponentRegistry,
	values: ..runtime.Raw_Any,
) -> ComponentMask {
	mask := mask_init()
	mask_add_raw_any(&mask, registry, ..values)
	return mask
}

mask_build_typeid :: proc(registry: ^ComponentRegistry, values: ..typeid) -> ComponentMask {
	mask := mask_init()
	mask_add_typeid(&mask, registry, ..values)
	return mask
}

mask_build :: proc {
	mask_build_u32,
	mask_build_raw_any,
	mask_build_typeid,
}

mask_match :: proc(query_mask, component_mask: ComponentMask) -> bool {
	words_to_check := min(len(query_mask.words), len(component_mask.words))

	for i in 0 ..< words_to_check {
		query_word := query_mask.words[i]
		component_word := component_mask.words[i]

		if query_word & component_word != query_word {
			return false
		}
	}

	return true
}

mask_get_components :: proc(mask: ComponentMask) -> [dynamic]u32 {
	result := [dynamic]u32{}

	for i in 0 ..< mask.word_count {
		for j in 0 ..< 64 {
			j := u32(j)
			checker_mask := u64le(1) << j
			if checker_mask & mask.words[i] > 0 {
				append(&result, i * 64 + j)
			}
		}
	}
	return result
}

mask_equal :: proc(a, b: ComponentMask) -> bool {
	if a.word_count != b.word_count {
		return false
	}

	for i in 0 ..< a.word_count {
		if a.words[i] != b.words[i] {
			return false
		}
	}

	return true
}
