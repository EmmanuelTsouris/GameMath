//
//  AABB.swift
//  GameMath
//
//  Axis-Aligned Bounding Box for collision detection
//

import Foundation

/// Axis-Aligned Bounding Box (AABB) for 2D collision detection
public struct AABB: Sendable, Hashable, Codable {
    /// Minimum point (bottom-left corner)
    public var min: Vector2D

    /// Maximum point (top-right corner)
    public var max: Vector2D

    // MARK: - Initialization

    /// Creates an AABB from min and max points
    public init(min: Vector2D, max: Vector2D) {
        self.min = min
        self.max = max
    }

    /// Creates an AABB from center and size
    public init(center: Vector2D, size: Vector2D) {
        let halfSize = size / 2
        self.min = center - halfSize
        self.max = center + halfSize
    }

    /// Creates an AABB from origin (min) and size
    public init(origin: Vector2D, size: Vector2D) {
        self.min = origin
        self.max = origin + size
    }

    // MARK: - Properties

    /// Center point of the AABB
    public var center: Vector2D {
        (min + max) / 2
    }

    /// Size (width, height) of the AABB
    public var size: Vector2D {
        max - min
    }

    /// Width of the AABB
    public var width: Float {
        max.x - min.x
    }

    /// Height of the AABB
    public var height: Float {
        max.y - min.y
    }

    /// Area of the AABB
    public var area: Float {
        width * height
    }

    // MARK: - Collision Detection

    /// Checks if a point is inside the AABB
    public func contains(_ point: Vector2D) -> Bool {
        point.x >= min.x && point.x <= max.x &&
        point.y >= min.y && point.y <= max.y
    }

    /// Checks if this AABB intersects with another AABB
    public func intersects(_ other: AABB) -> Bool {
        !(max.x < other.min.x || min.x > other.max.x ||
          max.y < other.min.y || min.y > other.max.y)
    }

    /// Checks if this AABB fully contains another AABB
    public func contains(_ other: AABB) -> Bool {
        other.min.x >= min.x && other.max.x <= max.x &&
        other.min.y >= min.y && other.max.y <= max.y
    }

    /// Returns the intersection AABB if two AABBs overlap, otherwise nil
    public func intersection(with other: AABB) -> AABB? {
        guard intersects(other) else { return nil }

        let newMin = Vector2D(
            x: Swift.max(min.x, other.min.x),
            y: Swift.max(min.y, other.min.y)
        )
        let newMax = Vector2D(
            x: Swift.min(max.x, other.max.x),
            y: Swift.min(max.y, other.max.y)
        )

        return AABB(min: newMin, max: newMax)
    }

    /// Returns the union AABB that contains both AABBs
    public func union(with other: AABB) -> AABB {
        let newMin = Vector2D(
            x: Swift.min(min.x, other.min.x),
            y: Swift.min(min.y, other.min.y)
        )
        let newMax = Vector2D(
            x: Swift.max(max.x, other.max.x),
            y: Swift.max(max.y, other.max.y)
        )

        return AABB(min: newMin, max: newMax)
    }

    /// Expands the AABB to include a point
    public func expanded(toInclude point: Vector2D) -> AABB {
        let newMin = Vector2D(
            x: Swift.min(min.x, point.x),
            y: Swift.min(min.y, point.y)
        )
        let newMax = Vector2D(
            x: Swift.max(max.x, point.x),
            y: Swift.max(max.y, point.y)
        )

        return AABB(min: newMin, max: newMax)
    }

    /// Expands the AABB by a given amount in all directions
    public func expanded(by amount: Float) -> AABB {
        let expansion = Vector2D(x: amount, y: amount)
        return AABB(min: min - expansion, max: max + expansion)
    }
}

// MARK: - CustomStringConvertible

extension AABB: CustomStringConvertible {
    public var description: String {
        "AABB(min: \(min), max: \(max))"
    }
}
