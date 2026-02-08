//
//  SIMDExtensions.swift
//  GameMath
//
//  Cross-platform SIMD operations that work on both Apple platforms and Linux
//

import Foundation

// MARK: - Type Aliases

/// 2D vector type backed by SIMD for performance
public typealias Vector2D = SIMD2<Float>

/// 3D vector type backed by SIMD for performance
public typealias Vector3D = SIMD3<Float>

// MARK: - Generic SIMD Extensions

extension SIMD where Scalar == Float {
    /// Squared length of the vector (avoids sqrt, useful for comparisons)
    @inlinable
    public var lengthSquared: Float {
        (self * self).sum()
    }

    /// Length (magnitude) of the vector
    @inlinable
    public var length: Float {
        sqrt(lengthSquared)
    }

    /// Normalized vector (length = 1), or zero if length is zero
    @inlinable
    public var normalized: Self {
        let len = length
        return len > 0 ? self / len : .zero
    }

    /// Dot product with another vector
    @inlinable
    public func dot(_ other: Self) -> Float {
        (self * other).sum()
    }

    /// Squared distance to another vector (avoids sqrt)
    @inlinable
    public func distanceSquared(to other: Self) -> Float {
        (self - other).lengthSquared
    }

    /// Distance to another vector
    @inlinable
    public func distance(to other: Self) -> Float {
        sqrt(distanceSquared(to: other))
    }

    /// Linear interpolation to another vector
    @inlinable
    public func mix(_ other: Self, t: Float) -> Self {
        self + (other - self) * t
    }

    /// Reflects vector across a normal
    @inlinable
    public func reflect(_ normal: Self) -> Self {
        self - 2 * self.dot(normal) * normal
    }

    /// Clamps vector components to a range (convenience wrapper)
    @inlinable
    public func clamped(min: Self, max: Self) -> Self {
        self.clamped(lowerBound: min, upperBound: max)
    }
}

// MARK: - SIMD2 Extensions (2D Vector Operations)

extension SIMD2 where Scalar == Float {
    // MARK: Labeled Initializers

    /// Creates a vector with labeled x and y components
    @inlinable
    public init(x: Float, y: Float) {
        self.init(x, y)
    }

    // MARK: Common Vectors

    /// Unit vector pointing right (1, 0)
    public static let right = SIMD2<Float>(1, 0)

    /// Unit vector pointing up (0, 1)
    public static let up = SIMD2<Float>(0, 1)

    /// Unit vector pointing left (-1, 0)
    public static let left = SIMD2<Float>(-1, 0)

    /// Unit vector pointing down (0, -1)
    public static let down = SIMD2<Float>(0, -1)

    /// Unit vector (1, 1)
    public static let one = SIMD2<Float>(1, 1)

    // MARK: 2D-Specific Operations

    /// Perpendicular vector (rotated 90° counterclockwise)
    @inlinable
    public var perpendicular: SIMD2<Float> {
        SIMD2<Float>(-y, x)
    }

    /// Angle in radians from positive x-axis
    @inlinable
    public var angle: Float {
        atan2(y, x)
    }

    /// 2D cross product magnitude (returns scalar)
    @inlinable
    public func cross(_ other: SIMD2<Float>) -> Float {
        x * other.y - y * other.x
    }

    /// Projects vector onto another vector
    @inlinable
    public func project(onto other: SIMD2<Float>) -> SIMD2<Float> {
        let otherLengthSq = other.lengthSquared
        guard otherLengthSq > 0 else { return .zero }
        let scale = dot(other) / otherLengthSq
        return other * scale
    }

    /// Linear interpolation to another vector (convenience for mix)
    @inlinable
    public func lerp(to other: SIMD2<Float>, t: Float) -> SIMD2<Float> {
        mix(other, t: t)
    }

    /// Reflects vector across a normal (convenience wrapper)
    @inlinable
    public func reflect(across normal: SIMD2<Float>) -> SIMD2<Float> {
        reflect(normal)
    }

    /// Creates vector from angle and length
    @inlinable
    public static func fromAngle(_ angle: Float, length: Float = 1) -> SIMD2<Float> {
        SIMD2<Float>(cos(angle) * length, sin(angle) * length)
    }
}

// MARK: - SIMD3 Extensions (3D Vector Operations)

extension SIMD3 where Scalar == Float {
    // MARK: Labeled Initializers

    /// Creates a vector with labeled x, y, and z components
    @inlinable
    public init(x: Float, y: Float, z: Float) {
        self.init(x, y, z)
    }

    // MARK: Common Vectors

    /// Unit vector pointing right (1, 0, 0)
    public static let right = SIMD3<Float>(1, 0, 0)

    /// Unit vector pointing up (0, 1, 0)
    public static let up = SIMD3<Float>(0, 1, 0)

    /// Unit vector pointing forward (0, 0, 1)
    public static let forward = SIMD3<Float>(0, 0, 1)

    /// Unit vector pointing left (-1, 0, 0)
    public static let left = SIMD3<Float>(-1, 0, 0)

    /// Unit vector pointing down (0, -1, 0)
    public static let down = SIMD3<Float>(0, -1, 0)

    /// Unit vector pointing back (0, 0, -1)
    public static let back = SIMD3<Float>(0, 0, -1)

    /// Unit vector (1, 1, 1)
    public static let one = SIMD3<Float>(1, 1, 1)

    // MARK: 3D-Specific Operations

    /// Cross product with another vector
    @inlinable
    public func cross(_ other: SIMD3<Float>) -> SIMD3<Float> {
        SIMD3<Float>(
            y * other.z - z * other.y,
            z * other.x - x * other.z,
            x * other.y - y * other.x
        )
    }

    /// XY components as a 2D vector
    @inlinable
    public var xy: SIMD2<Float> {
        SIMD2<Float>(x, y)
    }

    /// XZ components as a 2D vector
    @inlinable
    public var xz: SIMD2<Float> {
        SIMD2<Float>(x, z)
    }

    /// Projects vector onto another vector
    @inlinable
    public func project(onto other: SIMD3<Float>) -> SIMD3<Float> {
        let otherLengthSq = other.lengthSquared
        guard otherLengthSq > 0 else { return .zero }
        let scale = dot(other) / otherLengthSq
        return other * scale
    }

    /// Linear interpolation to another vector (convenience for mix)
    @inlinable
    public func lerp(to other: SIMD3<Float>, t: Float) -> SIMD3<Float> {
        mix(other, t: t)
    }

    /// Reflects vector across a normal (convenience wrapper)
    @inlinable
    public func reflect(across normal: SIMD3<Float>) -> SIMD3<Float> {
        reflect(normal)
    }

    /// Creates a 3D vector from a 2D vector (z = 0)
    @inlinable
    public init(_ vector2D: SIMD2<Float>, z: Float = 0) {
        self.init(vector2D.x, vector2D.y, z)
    }
}
