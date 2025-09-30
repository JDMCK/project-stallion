package tests


import ecs "../src"
import "core:testing"


@(test)
Col_init :: proc(t: ^Testing.T) {
	testing.expect_value(t, 1, 1)
}
