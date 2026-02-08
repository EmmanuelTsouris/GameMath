//
//  RandomUtils.swift
//  GameMath
//
//  Random number generation utilities with seeded generators
//

import Foundation

// MARK: - Seeded Random Number Generator

/// A seeded random number generator for deterministic randomness
public struct SeededRandom: Sendable {
    private var state: UInt64

    /// Creates a seeded random generator
    /// - Parameter seed: The seed value (default: current time)
    public init(seed: UInt64 = UInt64(Date().timeIntervalSince1970 * 1000000)) {
        self.state = seed
    }

    /// Generates the next random UInt64
    public mutating func next() -> UInt64 {
        // Xorshift64* algorithm
        state ^= state >> 12
        state ^= state << 25
        state ^= state >> 27
        return state &* 0x2545F4914F6CDD1D
    }

    /// Generates a random Float in [0, 1)
    public mutating func nextFloat() -> Float {
        Float(next() >> 40) / Float(1 << 24)
    }

    /// Generates a random Double in [0, 1)
    public mutating func nextDouble() -> Double {
        Double(next() >> 11) / Double(1 << 53)
    }

    /// Generates a random Int in a range
    public mutating func nextInt(in range: Range<Int>) -> Int {
        let span = range.upperBound - range.lowerBound
        return range.lowerBound + Int(next() % UInt64(span))
    }

    /// Generates a random Float in a range
    public mutating func nextFloat(in range: Range<Float>) -> Float {
        let span = range.upperBound - range.lowerBound
        return range.lowerBound + nextFloat() * span
    }

    /// Generates a random Bool
    public mutating func nextBool() -> Bool {
        next() & 1 == 0
    }

    /// Randomly shuffles an array in place
    public mutating func shuffle<T>(_ array: inout [T]) {
        for i in (1..<array.count).reversed() {
            let j = nextInt(in: 0..<(i + 1))
            array.swapAt(i, j)
        }
    }

    /// Returns a randomly shuffled copy of an array
    public mutating func shuffled<T>(_ array: [T]) -> [T] {
        var copy = array
        shuffle(&copy)
        return copy
    }
}

// MARK: - Random Extensions

extension Vector2D {
    /// Creates a random vector with components in [0, 1)
    public static func random(using rng: inout SeededRandom) -> Vector2D {
        Vector2D(x: rng.nextFloat(), y: rng.nextFloat())
    }

    /// Creates a random vector with components in a range
    public static func random(in range: Range<Float>, using rng: inout SeededRandom) -> Vector2D {
        Vector2D(
            x: rng.nextFloat(in: range),
            y: rng.nextFloat(in: range)
        )
    }

    /// Creates a random unit vector (length = 1)
    public static func randomDirection(using rng: inout SeededRandom) -> Vector2D {
        let angle = rng.nextFloat(in: 0..<(.pi * 2))
        return Vector2D.fromAngle(angle)
    }
}

extension Vector3D {
    /// Creates a random vector with components in [0, 1)
    public static func random(using rng: inout SeededRandom) -> Vector3D {
        Vector3D(x: rng.nextFloat(), y: rng.nextFloat(), z: rng.nextFloat())
    }

    /// Creates a random vector with components in a range
    public static func random(in range: Range<Float>, using rng: inout SeededRandom) -> Vector3D {
        Vector3D(
            x: rng.nextFloat(in: range),
            y: rng.nextFloat(in: range),
            z: rng.nextFloat(in: range)
        )
    }

    /// Creates a random unit vector on a sphere (length = 1)
    public static func randomDirection(using rng: inout SeededRandom) -> Vector3D {
        // Marsaglia's method for uniform sphere distribution
        var x, y, z: Float
        var lengthSquared: Float

        repeat {
            x = rng.nextFloat(in: -1..<1)
            y = rng.nextFloat(in: -1..<1)
            z = rng.nextFloat(in: -1..<1)
            lengthSquared = x * x + y * y + z * z
        } while lengthSquared > 1 || lengthSquared == 0

        let scale = 1 / sqrt(lengthSquared)
        return Vector3D(x: x * scale, y: y * scale, z: z * scale)
    }
}

// MARK: - Global Random Helpers

/// Returns a random Float in [0, 1)
public func randomFloat() -> Float {
    Float.random(in: 0..<1)
}

/// Returns a random Float in a range
public func randomFloat(in range: Range<Float>) -> Float {
    Float.random(in: range)
}

/// Returns a random Int in a range
public func randomInt(in range: Range<Int>) -> Int {
    Int.random(in: range)
}

/// Returns a random Bool
public func randomBool() -> Bool {
    Bool.random()
}

/// Returns a random element from an array
public func randomElement<T>(from array: [T]) -> T? {
    array.randomElement()
}
