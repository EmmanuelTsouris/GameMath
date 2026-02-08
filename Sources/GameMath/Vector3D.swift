//
//  Vector3D.swift
//  GameMath
//
//  3D vector type with SIMD-based operations
//

import Foundation

/// A 3D vector backed by SIMD for performance
public struct Vector3D: Sendable, Hashable, Codable {
    /// Internal SIMD storage
    private var storage: SIMD3<Float>

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

    /// Z component
    public var z: Float {
        get { storage.z }
        set { storage.z = newValue }
    }

    // MARK: - Initialization

    /// Creates a vector with the given x, y, and z components
    public init(x: Float, y: Float, z: Float) {
        self.storage = SIMD3<Float>(x, y, z)
    }

    /// Creates a vector from SIMD3
    public init(_ simd: SIMD3<Float>) {
        self.storage = simd
    }

    /// Creates a zero vector
    public init() {
        self.storage = SIMD3<Float>(0, 0, 0)
    }

    /// Creates a 3D vector from a 2D vector (z = 0)
    public init(_ vector2D: Vector2D, z: Float = 0) {
        self.storage = SIMD3<Float>(vector2D.x, vector2D.y, z)
    }

    // MARK: - Common Vectors

    /// Zero vector (0, 0, 0)
    public static let zero = Vector3D(x: 0, y: 0, z: 0)

    /// Unit vector pointing right (1, 0, 0)
    public static let right = Vector3D(x: 1, y: 0, z: 0)

    /// Unit vector pointing up (0, 1, 0)
    public static let up = Vector3D(x: 0, y: 1, z: 0)

    /// Unit vector pointing forward (0, 0, 1)
    public static let forward = Vector3D(x: 0, y: 0, z: 1)

    /// Unit vector pointing left (-1, 0, 0)
    public static let left = Vector3D(x: -1, y: 0, z: 0)

    /// Unit vector pointing down (0, -1, 0)
    public static let down = Vector3D(x: 0, y: -1, z: 0)

    /// Unit vector pointing back (0, 0, -1)
    public static let back = Vector3D(x: 0, y: 0, z: -1)

    /// Unit vector (1, 1, 1)
    public static let one = Vector3D(x: 1, y: 1, z: 1)

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
    public var normalized: Vector3D {
        let len = length
        return len > 0 ? Vector3D(storage / len) : .zero
    }

    /// XY components as a 2D vector
    public var xy: Vector2D {
        Vector2D(x: x, y: y)
    }

    /// XZ components as a 2D vector
    public var xz: Vector2D {
        Vector2D(x: x, y: z)
    }

    // MARK: - Operations

    /// Distance to another vector
    public func distance(to other: Vector3D) -> Float {
        storage.distance(to: other.storage)
    }

    /// Squared distance (avoids sqrt, useful for comparisons)
    public func distanceSquared(to other: Vector3D) -> Float {
        storage.distanceSquared(to: other.storage)
    }

    /// Dot product with another vector
    public func dot(_ other: Vector3D) -> Float {
        storage.dot(other.storage)
    }

    /// Cross product with another vector
    public func cross(_ other: Vector3D) -> Vector3D {
        Vector3D(storage.cross(other.storage))
    }

    /// Linear interpolation to another vector
    public func lerp(to other: Vector3D, t: Float) -> Vector3D {
        Vector3D(storage.mix(other.storage, t: t))
    }

    /// Reflects vector across a normal
    public func reflect(across normal: Vector3D) -> Vector3D {
        Vector3D(storage.reflect(normal.storage))
    }

    /// Projects vector onto another vector
    public func project(onto other: Vector3D) -> Vector3D {
        let otherLengthSq = other.lengthSquared
        guard otherLengthSq > 0 else { return .zero }
        let scale = dot(other) / otherLengthSq
        return other * scale
    }

    /// Clamps vector components to a range
    public func clamped(min: Vector3D, max: Vector3D) -> Vector3D {
        Vector3D(storage.clamped(lowerBound: min.storage, upperBound: max.storage))
    }
}

// MARK: - Arithmetic Operators

extension Vector3D {
    public static func + (lhs: Vector3D, rhs: Vector3D) -> Vector3D {
        Vector3D(lhs.storage + rhs.storage)
    }

    public static func - (lhs: Vector3D, rhs: Vector3D) -> Vector3D {
        Vector3D(lhs.storage - rhs.storage)
    }

    public static func * (lhs: Vector3D, rhs: Float) -> Vector3D {
        Vector3D(lhs.storage * rhs)
    }

    public static func * (lhs: Float, rhs: Vector3D) -> Vector3D {
        Vector3D(lhs * rhs.storage)
    }

    public static func / (lhs: Vector3D, rhs: Float) -> Vector3D {
        Vector3D(lhs.storage / rhs)
    }

    public static prefix func - (vector: Vector3D) -> Vector3D {
        Vector3D(-vector.storage)
    }

    public static func += (lhs: inout Vector3D, rhs: Vector3D) {
        lhs.storage += rhs.storage
    }

    public static func -= (lhs: inout Vector3D, rhs: Vector3D) {
        lhs.storage -= rhs.storage
    }

    public static func *= (lhs: inout Vector3D, rhs: Float) {
        lhs.storage *= rhs
    }

    public static func /= (lhs: inout Vector3D, rhs: Float) {
        lhs.storage /= rhs
    }
}

// MARK: - CustomStringConvertible

extension Vector3D: CustomStringConvertible {
    public var description: String {
        "Vector3D(x: \(x), y: \(y), z: \(z))"
    }
}
