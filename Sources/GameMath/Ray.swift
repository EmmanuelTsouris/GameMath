//
//  Ray.swift
//  GameMath
//
//  Ray for raycasting and intersection tests
//

import Foundation

/// A ray with an origin and direction for intersection tests
public struct Ray: Sendable, Hashable, Codable {
    /// Origin point of the ray
    public var origin: Vector2D

    /// Direction of the ray (should be normalized)
    public var direction: Vector2D

    // MARK: - Initialization

    /// Creates a ray with an origin and direction
    /// - Parameters:
    ///   - origin: Starting point of the ray
    ///   - direction: Direction vector (will be normalized)
    public init(origin: Vector2D, direction: Vector2D) {
        self.origin = origin
        self.direction = direction.normalized
    }

    // MARK: - Ray Operations

    /// Returns a point along the ray at a given distance
    public func point(at distance: Float) -> Vector2D {
        origin + direction * distance
    }

    // MARK: - Intersection Tests

    /// Ray-Circle intersection
    /// - Parameter circle: The circle to test against
    /// - Returns: Distance to intersection, or nil if no intersection
    public func intersects(_ circle: Circle) -> Float? {
        let oc = origin - circle.center
        let a = direction.lengthSquared
        let b = 2.0 * oc.dot(direction)
        let c = oc.lengthSquared - circle.radius * circle.radius
        let discriminant = b * b - 4 * a * c

        guard discriminant >= 0 else { return nil }

        let t1 = (-b - sqrt(discriminant)) / (2 * a)
        let t2 = (-b + sqrt(discriminant)) / (2 * a)

        // Return closest positive intersection
        if t1 >= 0 { return t1 }
        if t2 >= 0 { return t2 }
        return nil
    }

    /// Ray-AABB intersection (slab method)
    /// - Parameter aabb: The AABB to test against
    /// - Returns: Distance to intersection, or nil if no intersection
    public func intersects(_ aabb: AABB) -> Float? {
        var tMin: Float = 0
        var tMax: Float = .greatestFiniteMagnitude

        // X-axis slab
        if abs(direction.x) > .ulpOfOne {
            let tx1 = (aabb.min.x - origin.x) / direction.x
            let tx2 = (aabb.max.x - origin.x) / direction.x
            tMin = max(tMin, min(tx1, tx2))
            tMax = min(tMax, max(tx1, tx2))
        } else if origin.x < aabb.min.x || origin.x > aabb.max.x {
            return nil
        }

        // Y-axis slab
        if abs(direction.y) > .ulpOfOne {
            let ty1 = (aabb.min.y - origin.y) / direction.y
            let ty2 = (aabb.max.y - origin.y) / direction.y
            tMin = max(tMin, min(ty1, ty2))
            tMax = min(tMax, max(ty1, ty2))
        } else if origin.y < aabb.min.y || origin.y > aabb.max.y {
            return nil
        }

        guard tMax >= tMin && tMax >= 0 else { return nil }

        return tMin >= 0 ? tMin : tMax
    }

    /// Ray-Ray intersection (2D)
    /// - Parameter other: The other ray to test against
    /// - Returns: Distance to intersection on this ray, or nil if parallel/no intersection
    public func intersects(_ other: Ray) -> Float? {
        let cross = direction.cross(other.direction)

        // Parallel rays
        guard abs(cross) > .ulpOfOne else { return nil }

        let diff = other.origin - origin
        let t = diff.cross(other.direction) / cross
        let u = diff.cross(direction) / cross

        // Check if intersection is on both rays (positive direction)
        guard t >= 0 && u >= 0 else { return nil }

        return t
    }
}

// MARK: - CustomStringConvertible

extension Ray: CustomStringConvertible {
    public var description: String {
        "Ray(origin: \(origin), direction: \(direction))"
    }
}
