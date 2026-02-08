//
//  Vector2DTests.swift
//  GameMath
//

import Testing
import Foundation
@testable import GameMath

@Test("Vector2D initialization")
func testVector2DInit() {
    let v1 = Vector2D(x: 3, y: 4)
    #expect(v1.x == 3)
    #expect(v1.y == 4)

    let v2 = Vector2D()
    #expect(v2.x == 0)
    #expect(v2.y == 0)
}

@Test("Vector2D common vectors")
func testVector2DCommonVectors() {
    #expect(Vector2D.zero == Vector2D(x: 0, y: 0))
    #expect(Vector2D.right == Vector2D(x: 1, y: 0))
    #expect(Vector2D.up == Vector2D(x: 0, y: 1))
    #expect(Vector2D.left == Vector2D(x: -1, y: 0))
    #expect(Vector2D.down == Vector2D(x: 0, y: -1))
    #expect(Vector2D.one == Vector2D(x: 1, y: 1))
}

@Test("Vector2D length")
func testVector2DLength() {
    let v = Vector2D(x: 3, y: 4)
    #expect(v.length == 5)
    #expect(v.lengthSquared == 25)
}

@Test("Vector2D normalization")
func testVector2DNormalization() {
    let v = Vector2D(x: 3, y: 4)
    let normalized = v.normalized
    #expect(abs(normalized.length - 1) < 0.0001)

    let zero = Vector2D.zero
    #expect(zero.normalized == .zero)
}

@Test("Vector2D arithmetic")
func testVector2DArithmetic() {
    let v1 = Vector2D(x: 3, y: 4)
    let v2 = Vector2D(x: 1, y: 2)

    #expect(v1 + v2 == Vector2D(x: 4, y: 6))
    #expect(v1 - v2 == Vector2D(x: 2, y: 2))
    #expect(v1 * 2 == Vector2D(x: 6, y: 8))
    #expect(v1 / 2 == Vector2D(x: 1.5, y: 2))
    #expect(-v1 == Vector2D(x: -3, y: -4))
}

@Test("Vector2D dot product")
func testVector2DDot() {
    let v1 = Vector2D(x: 3, y: 4)
    let v2 = Vector2D(x: 1, y: 2)
    #expect(v1.dot(v2) == 11)

    let perpendicular1 = Vector2D(x: 1, y: 0)
    let perpendicular2 = Vector2D(x: 0, y: 1)
    #expect(perpendicular1.dot(perpendicular2) == 0)
}

@Test("Vector2D cross product")
func testVector2DCross() {
    let v1 = Vector2D(x: 1, y: 0)
    let v2 = Vector2D(x: 0, y: 1)
    #expect(v1.cross(v2) == 1)
    #expect(v2.cross(v1) == -1)
}

@Test("Vector2D distance")
func testVector2DDistance() {
    let v1 = Vector2D(x: 0, y: 0)
    let v2 = Vector2D(x: 3, y: 4)
    #expect(v1.distance(to: v2) == 5)
    #expect(v1.distanceSquared(to: v2) == 25)
}

@Test("Vector2D lerp")
func testVector2DLerp() {
    let v1 = Vector2D(x: 0, y: 0)
    let v2 = Vector2D(x: 10, y: 10)
    let mid = v1.lerp(to: v2, t: 0.5)
    #expect(mid == Vector2D(x: 5, y: 5))
}

@Test("Vector2D perpendicular")
func testVector2DPerpendicular() {
    let v = Vector2D(x: 1, y: 0)
    let perp = v.perpendicular
    #expect(perp == Vector2D(x: 0, y: 1))
    #expect(v.dot(perp) == 0) // Should be orthogonal
}

@Test("Vector2D from angle")
func testVector2DFromAngle() {
    let v = Vector2D.fromAngle(0, length: 1)
    #expect(abs(v.x - 1) < 0.0001)
    #expect(abs(v.y) < 0.0001)

    let v2 = Vector2D.fromAngle(.pi / 2, length: 1)
    #expect(abs(v2.x) < 0.0001)
    #expect(abs(v2.y - 1) < 0.0001)
}

@Test("Vector2D clamping")
func testVector2DClamping() {
    let v = Vector2D(x: 5, y: 10)
    let clamped = v.clamped(
        min: Vector2D(x: 0, y: 0),
        max: Vector2D(x: 3, y: 8)
    )
    #expect(clamped == Vector2D(x: 3, y: 8))
}
