//! Comprehensive physics integration tests
//! Tests gravity application, friction, collision handling, and integration
//! with the R6 character system for realistic physics simulation.

const std = @import("std");
const testing = std.testing;
const expect = testing.expect;
const expectEqual = testing.expectEqual;
const expectApproxEqRel = testing.expectApproxEqRel;

const r6_character = @import("../r6_character.zig");
const main = @import("../main.zig");

// Import physics-related types
const R6Physics = r6_character.R6Physics;
const R6Character = r6_character.R6Character;
const Vec3 = main.Vec3;
const AnimationState = r6_character.AnimationState;

const EPSILON = 0.001;
const FRAME_TIME: f32 = 1.0 / 60.0; // 60 FPS
const GRAVITY_CONSTANT: f32 = 9.81;

// Test allocator
var test_allocator = std.testing.allocator;

// =============================================================================
// PHYSICS INITIALIZATION TESTS
// =============================================================================

test "R6Physics default initialization" {
    var physics = R6Physics.init();

    // Test that default values are reasonable for game physics
    try expect(physics.mass > 0);
    try expect(physics.mass < 1000); // Reasonable upper bound

    try expect(physics.friction >= 0);
    try expect(physics.friction <= 1); // Friction coefficient should be normalized

    try expect(physics.air_resistance >= 0);
    try expect(physics.air_resistance < 1); // Should not completely stop movement instantly

    try expect(physics.gravity_scale > 0);
    try expect(physics.gravity_scale <= 2); // Reasonable gravity multiplier

    try expect(physics.bounce_factor >= 0);
    try expect(physics.bounce_factor <= 1); // Should not add energy to system
}