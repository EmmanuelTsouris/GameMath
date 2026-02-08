//
//  Vector2D.swift
//  GameMath
//
//  2D vector type with SIMD-based operations
//

import Foundation

/// A 2D vector backed by SIMD for performance
public struct Vector2D: Sendable, Hashable, Codable {
    /// Internal SIMD storage
    private var storage: SIMD2<Float>

    /// X component
    public var x: Float {
        get { storage.x }
        set { storage.x = newValue }
    }

    /// Y component
    public var y: Float {
        get { storage.y }
        set { storage.y = newValue }
    }

    // MARK: - Initialization

    /// Creates a vector with the given x and y components
    public init(x: Float, y: Float) {
        self.storage = SIMD2<Float>(x, y)
    }

    /// Creates a vector from SIMD2
    public init(_ simd: SIMD2<Float>) {
        self.storage = simd
    }

    /// Creates a zero vector
    public init() {
        self.storage = SIMD2<Float>(0, 0)
    }

    // MARK: - Common Vectors

    /// Zero vector (0, 0)
    public static let zero = Vector2D(x: 0, y: 0)

    /// Unit vector pointing right (1, 0)
    public static let right = Vector2D(x: 1, y: 0)

    /// Unit vector pointing up (0, 1)
    public static let up = Vector2D(x: 0, y: 1)

    /// Unit vector pointing left (-1, 0)
    public static let left = Vector2D(x: -1, y: 0)

    /// Unit vector pointing down (0, -1)
    public static let down = Vector2D(x: 0, y: -1)

    /// Unit vector (1, 1)
    public static let one = Vector2D(x: 1, y: 1)

    // MARK: - Properties

    /// Length (magnitude) of the vector
    public var length: Float {
        storage.length
    }

    /// Squared length (avoids sqrt, useful for comparisons)
    public var lengthSquared: Float {
        storage.lengthSquared
    }

    /// Normalized vector (length = 1), or zero if length is zero
    public var normalized: Vector2D {
        let len = length
        return len > 0 ? Vector2D(storage / len) : .zero
    }

    /// Perpendicular vector (rotated 90° counterclockwise)
    public var perpendicular: Vector2D {
        Vector2D(x: -y, y: x)
    }

    /// Angle in radians from positive x-axis
    public var angle: Float {
        atan2(y, x)
    }

    // MARK: - Operations

    /// Distance to another vector
    public func distance(to other: Vector2D) -> Float {
        storage.distance(to: other.storage)
    }

    /// Squared distance (avoids sqrt, useful for comparisons)
    public func distanceSquared(to other: Vector2D) -> Float {
        storage.distanceSquared(to: other.storage)
    }

    /// Dot product with another vector
    public func dot(_ other: Vector2D) -> Float {
        storage.dot(other.storage)
    }

    /// Cross product magnitude (2D cross product returns scalar)
    public func cross(_ other: Vector2D) -> Float {
        x * other.y - y * other.x
    }

    /// Linear interpolation to another vector
    public func lerp(to other: Vector2D, t: Float) -> Vector2D {
        Vector2D(storage.mix(other.storage, t: t))
    }

    /// Reflects vector across a normal
    public func reflect(across normal: Vector2D) -> Vector2D {
        Vector2D(storage.reflect(normal.storage))
    }

    /// Projects vector onto another vector
    public func project(onto other: Vector2D) -> Vector2D {
        let otherLengthSq = other.lengthSquared
        guard otherLengthSq > 0 else { return .zero }
        let scale = dot(other) / otherLengthSq
        return other * scale
    }

    /// Clamps vector components to a range
    public func clamped(min: Vector2D, max: Vector2D) -> Vector2D {
        Vector2D(storage.clamped(lowerBound: min.storage, upperBound: max.storage))
    }

    /// Creates vector from angle and length
    public static func fromAngle(_ angle: Float, length: Float = 1) -> Vector2D {
        Vector2D(x: cos(angle) * length, y: sin(angle) * length)
    }
}

// MARK: - Arithmetic Operators

extension Vector2D {
    public static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        Vector2D(lhs.storage + rhs.storage)
    }

    public static func - (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        Vector2D(lhs.storage - rhs.storage)
    }

    public static func * (lhs: Vector2D, rhs: Float) -> Vector2D {
        Vector2D(lhs.storage * rhs)
    }

    public static func * (lhs: Float, rhs: Vector2D) -> Vector2D {
        Vector2D(lhs * rhs.storage)
    }

    public static func / (lhs: Vector2D, rhs: Float) -> Vector2D {
        Vector2D(lhs.storage / rhs)
    }

    public static prefix func - (vector: Vector2D) -> Vector2D {
        Vector2D(-vector.storage)
    }

    public static func += (lhs: inout Vector2D, rhs: Vector2D) {
        lhs.storage += rhs.storage
    }

    public static func -= (lhs: inout Vector2D, rhs: Vector2D) {
        lhs.storage -= rhs.storage
    }

    public static func *= (lhs: inout Vector2D, rhs: Float) {
        lhs.storage *= rhs
    }

    public static func /= (lhs: inout Vector2D, rhs: Float) {
        lhs.storage /= rhs
    }
}

// MARK: - CustomStringConvertible

extension Vector2D: CustomStringConvertible {
    public var description: String {
        "Vector2D(x: \(x), y: \(y))"
    }
}
