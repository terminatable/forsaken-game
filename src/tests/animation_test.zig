//! Comprehensive animation system tests
//! Tests animation state machine transitions, blending, procedural generation,
//! and performance characteristics of the R6 animation system.

const std = @import("std");
const testing = std.testing;
const expect = testing.expect;
const expectEqual = testing.expectEqual;
const expectApproxEqRel = testing.expectApproxEqRel;

const r6_character = @import("../r6_character.zig");
const main = @import("../main.zig");

// Import animation-related types
const AnimationState = r6_character.AnimationState;
const AnimationParams = r6_character.AnimationParams;
const ProceduralAnimator = r6_character.ProceduralAnimator;
const R6Character = r6_character.R6Character;
const R6Body = r6_character.R6Body;
const BodyPart = r6_character.BodyPart;
const Vec3 = main.Vec3;

const EPSILON = 0.001;
const FRAME_TIME: f32 = 1.0 / 60.0; // 60 FPS

// Test allocator
var test_allocator = std.testing.allocator;

// =============================================================================
// ANIMATION STATE TESTS
// =============================================================================

test "AnimationState enum completeness" {
    // Test that all animation states have valid display names
    const all_states = [_]AnimationState{ .idle, .walking, .running, .jumping, .falling, .landing, .attacking, .blocking, .casting_spell, .crouching, .swimming, .climbing, .death };

    for (all_states) |state| {
        const display_name = state.getDisplayName();
        try expect(display_name.len > 0);
        try expect(display_name.len < 20); // Reasonable length limit
    }
}