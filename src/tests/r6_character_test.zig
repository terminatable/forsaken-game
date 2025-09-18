//! Comprehensive unit tests for R6 character system
//! Tests movement calculations, animation transitions, physics interactions,
//! character preset loading/saving, and procedural animation generation.

const std = @import("std");
const testing = std.testing;
const expect = testing.expect;
const expectEqual = testing.expectEqual;
const expectApproxEqRel = testing.expectApproxEqRel;

const r6_character = @import("../r6_character.zig");
const main = @import("../main.zig");

// Import all the types we need to test
const R6Character = r6_character.R6Character;
const R6Body = r6_character.R6Body;
const R6BodyPart = r6_character.R6BodyPart;
const BodyPart = r6_character.BodyPart;
const Joint = r6_character.Joint;
const AnimationState = r6_character.AnimationState;
const AnimationParams = r6_character.AnimationParams;
const ProceduralAnimator = r6_character.ProceduralAnimator;
const CharacterPreset = r6_character.CharacterPreset;
const R6Physics = r6_character.R6Physics;
const Vec3 = main.Vec3;
const Transform = main.Transform;

const EPSILON = 0.001;

// Test allocator for memory management tests
var test_allocator = std.testing.allocator;

// =============================================================================
// BODY PART AND JOINT TESTS
// =============================================================================

test "BodyPart enum functionality" {
    // Test part names
    try expectEqual(@as([]const u8, "Head"), BodyPart.head.getPartName());
    try expectEqual(@as([]const u8, "Torso"), BodyPart.torso.getPartName());
    try expectEqual(@as([]const u8, "Left Arm"), BodyPart.left_arm.getPartName());

    // Test default sizes
    const head_size = BodyPart.head.getDefaultSize();
    try expect(head_size.x > 0 and head_size.y > 0 and head_size.z > 0);

    // Test default colors
    const head_color = BodyPart.head.getDefaultColor();
    try expect(head_color.x >= 0 and head_color.x <= 1);
    try expect(head_color.y >= 0 and head_color.y <= 1);
    try expect(head_color.z >= 0 and head_color.z <= 1);
}

test "R6BodyPart creation and modification" {
    var body_part = R6BodyPart.init(BodyPart.head, Transform.init());

    // Test initial values
    try expectEqual(BodyPart.head, body_part.part_type);
    try expectEqual(true, body_part.visible);

    // Test color setting
    const new_color = Vec3.init(0.5, 0.7, 0.3);
    body_part.setColor(new_color);
    try expectApproxEqRel(new_color.x, body_part.color.x, EPSILON);
    try expectApproxEqRel(new_color.y, body_part.color.y, EPSILON);
    try expectApproxEqRel(new_color.z, body_part.color.z, EPSILON);

    // Test size setting
    const new_size = Vec3.init(1.2, 1.5, 0.8);
    body_part.setSize(new_size);
    try expectApproxEqRel(new_size.x, body_part.size.x, EPSILON);
    try expectApproxEqRel(new_size.y, body_part.size.y, EPSILON);
    try expectApproxEqRel(new_size.z, body_part.size.z, EPSILON);
}