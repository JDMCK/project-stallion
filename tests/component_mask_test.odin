package tests

import ecs "../src"
import "core:fmt"
import "core:log"
import "core:testing"

@(test)
mask_build :: proc(t: ^testing.T) {
	mask := ecs.mask_build(63, 64)
	defer ecs.mask_destroy(&mask)

	testing.expect_value(t, mask.word_count, 2)
	testing.expect_value(t, len(mask.words), 2)

	expected := u64le(1) << 63
	testing.expect_value(t, mask.words[0], expected)

	expected = u64le(1)
	testing.expect_value(t, mask.words[1], expected)
}

@(test)
mask_add :: proc(t: ^testing.T) {
	mask := ecs.mask_init()
	defer ecs.mask_destroy(&mask)

	for i in 0 ..< 64 {
		ecs.mask_add(&mask, u32(i))
	}

	testing.expect_value(t, len(mask.words), 1)
	expected: u128 = 1 << 65 - 1
	testing.expect_value(t, mask.words[0], u64le(expected))
}

@(test)
mask_match :: proc(t: ^testing.T) {
	mask := ecs.mask_build(1, 3, 5, 64, 128)
	query_mask_1 := ecs.mask_build(1, 5, 128)
	query_mask_2 := ecs.mask_build(64, 128)
	query_mask_3 := ecs.mask_build(1, 3, 5, 64, 129)
	defer ecs.mask_destroy(&mask)
	defer ecs.mask_destroy(&query_mask_1)
	defer ecs.mask_destroy(&query_mask_2)
	defer ecs.mask_destroy(&query_mask_3)

	testing.expect_value(t, ecs.mask_match(&query_mask_1, &mask), true)
	testing.expect_value(t, ecs.mask_match(&query_mask_2, &mask), true)
	testing.expect_value(t, ecs.mask_match(&query_mask_3, &mask), false)
}

@(test)
mask_get_components :: proc(t: ^testing.T) {
	mask := ecs.mask_build(1, 3, 5, 64, 128)
	result := ecs.mask_get_components(mask)
	defer ecs.mask_destroy(&mask)
	defer delete(result)

	log.info(result)
	ok := slice_equals(u32, result[:], []u32{1, 3, 5, 64, 128})
	testing.expect(t, ok, "Failed to get components.")
}
