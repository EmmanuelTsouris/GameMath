//
//  SIMDExtensions.swift
//  GameMath
//
//  Cross-platform SIMD operations that work on both Apple platforms and Linux
//

import Foundation

// MARK: - SIMD2 Extensions

extension SIMD2 where Scalar == Float {
    /// Dot product of two vectors
    @inlinable
    var dot: Float {
        (self * self).sum()
    }

    /// Squared length of the vector
    @inlinable
    var lengthSquared: Float {
        dot
    }

    /// Length (magnitude) of the vector
    @inlinable
    var length: Float {
        sqrt(lengthSquared)
    }

    /// Dot product with another vector
    @inlinable
    func dot(_ other: SIMD2<Float>) -> Float {
        (self * other).sum()
    }

    /// Squared distance to another vector
    @inlinable
    func distanceSquared(to other: SIMD2<Float>) -> Float {
        (self - other).lengthSquared
    }

    /// Distance to another vector
    @inlinable
    func distance(to other: SIMD2<Float>) -> Float {
        sqrt(distanceSquared(to: other))
    }

    /// Linear interpolation to another vector
    @inlinable
    func mix(_ other: SIMD2<Float>, t: Float) -> SIMD2<Float> {
        self + (other - self) * t
    }

    /// Reflects vector across a normal
    @inlinable
    func reflect(_ normal: SIMD2<Float>) -> SIMD2<Float> {
        self - 2 * self.dot(normal) * normal
    }
}

// MARK: - SIMD3 Extensions

extension SIMD3 where Scalar == Float {
    /// Dot product of two vectors
    @inlinable
    var dot: Float {
        (self * self).sum()
    }

    /// Squared length of the vector
    @inlinable
    var lengthSquared: Float {
        dot
    }

    /// Length (magnitude) of the vector
    @inlinable
    var length: Float {
        sqrt(lengthSquared)
    }

    /// Dot product with another vector
    @inlinable
    func dot(_ other: SIMD3<Float>) -> Float {
        (self * other).sum()
    }

    /// Squared distance to another vector
    @inlinable
    func distanceSquared(to other: SIMD3<Float>) -> Float {
        (self - other).lengthSquared
    }

    /// Distance to another vector
    @inlinable
    func distance(to other: SIMD3<Float>) -> Float {
        sqrt(distanceSquared(to: other))
    }

    /// Cross product with another vector
    @inlinable
    func cross(_ other: SIMD3<Float>) -> SIMD3<Float> {
        SIMD3<Float>(
            y * other.z - z * other.y,
            z * other.x - x * other.z,
            x * other.y - y * other.x
        )
    }

    /// Linear interpolation to another vector
    @inlinable
    func mix(_ other: SIMD3<Float>, t: Float) -> SIMD3<Float> {
        self + (other - self) * t
    }

    /// Reflects vector across a normal
    @inlinable
    func reflect(_ normal: SIMD3<Float>) -> SIMD3<Float> {
        self - 2 * self.dot(normal) * normal
    }
}
