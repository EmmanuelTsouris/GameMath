//
//  Circle.swift
//  GameMath
//
//  Circle shape for 2D collision detection
//

import Foundation

/// Circle shape for 2D collision detection
public struct Circle: Sendable, Hashable, Codable {
    /// Center point of the circle
    public var center: Vector2D

    /// Radius of the circle
    public var radius: Float

    // MARK: - Initialization

    /// Creates a circle with a center and radius
    public init(center: Vector2D, radius: Float) {
        self.center = center
        self.radius = radius
    }

    // MARK: - Properties

    /// Diameter of the circle
    public var diameter: Float {
        radius * 2
    }

    /// Area of the circle
    public var area: Float {
        .pi * radius * radius
    }

    /// Circumference of the circle
    public var circumference: Float {
        2 * .pi * radius
    }

    /// Bounding box of the circle
    public var boundingBox: AABB {
        let halfSize = Vector2D(x: radius, y: radius)
        return AABB(min: center - halfSize, max: center + halfSize)
    }

    // MARK: - Collision Detection

    /// Checks if a point is inside the circle
    public func contains(_ point: Vector2D) -> Bool {
        center.distanceSquared(to: point) <= radius * radius
    }

    /// Checks if this circle intersects with another circle
    public func intersects(_ other: Circle) -> Bool {
        let combinedRadius = radius + other.radius
        return center.distanceSquared(to: other.center) <= combinedRadius * combinedRadius
    }

    /// Checks if this circle fully contains another circle
    public func contains(_ other: Circle) -> Bool {
        let radiusDiff = radius - other.radius
        guard radiusDiff >= 0 else { return false }
        return center.distanceSquared(to: other.center) <= radiusDiff * radiusDiff
    }

    /// Checks if this circle intersects with an AABB
    public func intersects(_ aabb: AABB) -> Bool {
        // Find closest point on AABB to circle center
        let closest = Vector2D(
            x: Swift.max(aabb.min.x, Swift.min(center.x, aabb.max.x)),
            y: Swift.max(aabb.min.y, Swift.min(center.y, aabb.max.y))
        )

        // Check if closest point is within radius
        return center.distanceSquared(to: closest) <= radius * radius
    }

    /// Returns the point on the circle's edge closest to a given point
    public func closestPoint(to point: Vector2D) -> Vector2D {
        let direction = (point - center).normalized
        return center + direction * radius
    }
}

// MARK: - CustomStringConvertible

extension Circle: CustomStringConvertible {
    public var description: String {
        "Circle(center: \(center), radius: \(radius))"
    }
}
