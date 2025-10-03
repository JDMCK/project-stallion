package ecs

import "core:fmt"
import "core:slice"

ComponentMask :: struct {
	words:      [dynamic]u64le,
	word_count: u32,
}

mask_init :: proc() -> ComponentMask {
	return ComponentMask{words = [dynamic]u64le{}, word_count = 0}
}

mask_destroy :: proc(mask: ^ComponentMask) {
	delete(mask.words)
}

mask_add_Component :: proc(mask: ^ComponentMask, values: ..Component) {
	// increase word_count if necessary
	max_value := slice.max(values)
	word_count := u32(max_value) / 64 + 1
	if mask.word_count < word_count {
		for _ in 0 ..< word_count - mask.word_count {
			append(&mask.words, 0)
		}
		mask.word_count = word_count
	}

	// set bits
	for v, i in values {
		v := u32(v)
		word_index := v / 64
		word := u64le(1) << (v % 64)
		mask.words[word_index] |= word
	}
}

mask_add_u32 :: proc(mask: ^ComponentMask, values: ..u32) {
	// increase word_count if necessary
	max_value := slice.max(values)
	word_count := max_value / 64 + 1
	if mask.word_count < word_count {
		for _ in 0 ..< word_count - mask.word_count {
			append(&mask.words, 0)
		}
		mask.word_count = word_count
	}

	// set bits
	for v, i in values {
		word_index := v / 64
		word := u64le(1) << (v % 64)
		mask.words[word_index] |= word
	}
}

mask_add :: proc {
	mask_add_Component,
	mask_add_u32,
}

mask_build_Component :: proc(values: ..Component) -> ComponentMask {
	mask := mask_init()
	mask_add(&mask, ..values)
	return mask
}

mask_build_u32 :: proc(values: ..u32) -> ComponentMask {
	mask := mask_init()
	mask_add(&mask, ..values)
	return mask
}

mask_build :: proc {
	mask_build_Component,
	mask_build_u32,
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
