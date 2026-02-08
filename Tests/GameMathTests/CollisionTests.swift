//
//  CollisionTests.swift
//  GameMath
//

import Testing
import Foundation
@testable import GameMath

// MARK: - AABB Tests

@Test("AABB initialization and properties")
func testAABBInit() {
    let aabb = AABB(min: Vector2D(x: 0, y: 0), max: Vector2D(x: 10, y: 10))
    #expect(aabb.center == Vector2D(x: 5, y: 5))
    #expect(aabb.size == Vector2D(x: 10, y: 10))
    #expect(aabb.width == 10)
    #expect(aabb.height == 10)
    #expect(aabb.area == 100)
}

@Test("AABB contains point")
func testAABBContainsPoint() {
    let aabb = AABB(center: Vector2D(x: 5, y: 5), size: Vector2D(x: 10, y: 10))

    #expect(aabb.contains(Vector2D(x: 5, y: 5))) // Center
    #expect(aabb.contains(Vector2D(x: 0, y: 0))) // Min edge
    #expect(aabb.contains(Vector2D(x: 10, y: 10))) // Max edge
    #expect(!aabb.contains(Vector2D(x: -1, y: 5))) // Outside
    #expect(!aabb.contains(Vector2D(x: 11, y: 5))) // Outside
}

@Test("AABB intersects AABB")
func testAABBIntersection() {
    let aabb1 = AABB(min: Vector2D(x: 0, y: 0), max: Vector2D(x: 10, y: 10))
    let aabb2 = AABB(min: Vector2D(x: 5, y: 5), max: Vector2D(x: 15, y: 15))
    let aabb3 = AABB(min: Vector2D(x: 20, y: 20), max: Vector2D(x: 30, y: 30))

    #expect(aabb1.intersects(aabb2)) // Overlapping
    #expect(!aabb1.intersects(aabb3)) // Separated
}

@Test("AABB contains AABB")
func testAABBContainsAABB() {
    let outer = AABB(min: Vector2D(x: 0, y: 0), max: Vector2D(x: 20, y: 20))
    let inner = AABB(min: Vector2D(x: 5, y: 5), max: Vector2D(x: 15, y: 15))
    let partial = AABB(min: Vector2D(x: 10, y: 10), max: Vector2D(x: 30, y: 30))

    #expect(outer.contains(inner))
    #expect(!outer.contains(partial))
    #expect(!inner.contains(outer))
}

@Test("AABB union and expansion")
func testAABBUnion() {
    let aabb1 = AABB(min: Vector2D(x: 0, y: 0), max: Vector2D(x: 10, y: 10))
    let aabb2 = AABB(min: Vector2D(x: 5, y: 5), max: Vector2D(x: 15, y: 15))
    let union = aabb1.union(with: aabb2)

    #expect(union.min == Vector2D(x: 0, y: 0))
    #expect(union.max == Vector2D(x: 15, y: 15))
}

// MARK: - Circle Tests

@Test("Circle initialization and properties")
func testCircleInit() {
    let circle = Circle(center: Vector2D(x: 5, y: 5), radius: 10)
    #expect(circle.diameter == 20)
    #expect(abs(circle.area - (.pi * 100)) < 0.001)
    #expect(abs(circle.circumference - (2 * .pi * 10)) < 0.001)
}

@Test("Circle contains point")
func testCircleContainsPoint() {
    let circle = Circle(center: Vector2D.zero, radius: 5)

    #expect(circle.contains(Vector2D.zero)) // Center
    #expect(circle.contains(Vector2D(x: 3, y: 4))) // Inside (3²+4²=25, radius²=25)
    #expect(!circle.contains(Vector2D(x: 5, y: 5))) // Outside
}

@Test("Circle intersects Circle")
func testCircleIntersectsCircle() {
    let c1 = Circle(center: Vector2D(x: 0, y: 0), radius: 5)
    let c2 = Circle(center: Vector2D(x: 8, y: 0), radius: 5) // Overlapping
    let c3 = Circle(center: Vector2D(x: 20, y: 0), radius: 5) // Separated

    #expect(c1.intersects(c2))
    #expect(!c1.intersects(c3))
}

@Test("Circle intersects AABB")
func testCircleIntersectsAABB() {
    let circle = Circle(center: Vector2D(x: 10, y: 10), radius: 5)
    let aabb1 = AABB(min: Vector2D(x: 0, y: 0), max: Vector2D(x: 15, y: 15)) // Overlapping
    let aabb2 = AABB(min: Vector2D(x: 20, y: 20), max: Vector2D(x: 30, y: 30)) // Separated

    #expect(circle.intersects(aabb1))
    #expect(!circle.intersects(aabb2))
}

// MARK: - Ray Tests

@Test("Ray initialization")
func testRayInit() {
    let ray = Ray(origin: Vector2D.zero, direction: Vector2D(x: 1, y: 1))
    #expect(abs(ray.direction.length - 1) < 0.0001) // Should be normalized
}

@Test("Ray point at distance")
func testRayPoint() {
    let ray = Ray(origin: Vector2D.zero, direction: Vector2D.right)
    let point = ray.point(at: 10)
    #expect(point == Vector2D(x: 10, y: 0))
}

@Test("Ray intersects Circle")
func testRayIntersectsCircle() {
    let ray = Ray(origin: Vector2D(x: -10, y: 0), direction: Vector2D.right)
    let circle = Circle(center: Vector2D.zero, radius: 5)

    let distance = ray.intersects(circle)
    #expect(distance != nil)
    #expect(abs(distance! - 5) < 0.0001) // Should hit at x=-5
}

@Test("Ray intersects AABB")
func testRayIntersectsAABB() {
    let ray = Ray(origin: Vector2D(x: -10, y: 5), direction: Vector2D.right)
    let aabb = AABB(min: Vector2D.zero, max: Vector2D(x: 10, y: 10))

    let distance = ray.intersects(aabb)
    #expect(distance != nil)
    #expect(abs(distance! - 10) < 0.0001) // Should hit at x=0
}

@Test("Ray misses target")
func testRayMiss() {
    let ray = Ray(origin: Vector2D(x: -10, y: 20), direction: Vector2D.right)
    let circle = Circle(center: Vector2D.zero, radius: 5)
    let aabb = AABB(min: Vector2D.zero, max: Vector2D(x: 10, y: 10))

    #expect(ray.intersects(circle) == nil)
    #expect(ray.intersects(aabb) == nil)
}
