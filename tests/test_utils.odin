package tests

import "core:log"

slice_equals :: proc($T: typeid, a: []T, b: []T) -> bool {
	log.info("a: ", a, "b: ", b)
	if len(a) != len(b) {
		return false
	}
	for i in 0 ..< len(a) {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}
