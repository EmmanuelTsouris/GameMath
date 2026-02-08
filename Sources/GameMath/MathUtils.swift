//
//  MathUtils.swift
//  GameMath
//
//  General math utility functions
//

import Foundation

// MARK: - Interpolation

/// Linear interpolation between two values
/// - Parameters:
///   - a: Start value
///   - b: End value
///   - t: Interpolation factor (0...1)
/// - Returns: Interpolated value
public func lerp<T: BinaryFloatingPoint>(_ a: T, _ b: T, _ t: T) -> T {
    a + (b - a) * t
}

/// Smooth interpolation (ease-in-out cubic)
/// - Parameters:
///   - a: Start value
///   - b: End value
///   - t: Interpolation factor (0...1)
/// - Returns: Smoothly interpolated value
public func smoothstep<T: BinaryFloatingPoint>(_ a: T, _ b: T, _ t: T) -> T {
    let clamped = clamp(t, 0, 1)
    let smoothed = clamped * clamped * (3 - 2 * clamped)
    return a + (b - a) * smoothed
}

/// Smoother interpolation (ease-in-out quintic)
/// - Parameters:
///   - a: Start value
///   - b: End value
///   - t: Interpolation factor (0...1)
/// - Returns: Very smoothly interpolated value
public func smootherstep<T: BinaryFloatingPoint>(_ a: T, _ b: T, _ t: T) -> T {
    let clamped = clamp(t, 0, 1)
    let smoothed = clamped * clamped * clamped * (clamped * (clamped * 6 - 15) + 10)
    return a + (b - a) * smoothed
}

/// Cubic bezier interpolation
/// - Parameters:
///   - p0: Start point
///   - p1: First control point
///   - p2: Second control point
///   - p3: End point
///   - t: Interpolation factor (0...1)
/// - Returns: Point on cubic bezier curve
public func cubicBezier<T: BinaryFloatingPoint>(_ p0: T, _ p1: T, _ p2: T, _ p3: T, _ t: T) -> T {
    let oneMinusT = 1 - t
    let a = oneMinusT * oneMinusT * oneMinusT
    let b = 3 * oneMinusT * oneMinusT * t
    let c = 3 * oneMinusT * t * t
    let d = t * t * t
    return a * p0 + b * p1 + c * p2 + d * p3
}

// MARK: - Clamping and Mapping

/// Clamps a value between min and max
/// - Parameters:
///   - value: Value to clamp
///   - min: Minimum value
///   - max: Maximum value
/// - Returns: Clamped value
public func clamp<T: Comparable>(_ value: T, _ min: T, _ max: T) -> T {
    Swift.max(min, Swift.min(max, value))
}

/// Remaps a value from one range to another
/// - Parameters:
///   - value: Value to remap
///   - fromMin: Original range minimum
///   - fromMax: Original range maximum
///   - toMin: Target range minimum
///   - toMax: Target range maximum
/// - Returns: Remapped value
public func remap<T: BinaryFloatingPoint>(_ value: T, from fromMin: T, _ fromMax: T, to toMin: T, _ toMax: T) -> T {
    let normalized = (value - fromMin) / (fromMax - fromMin)
    return toMin + normalized * (toMax - toMin)
}

/// Returns the fractional part of a value
public func fract<T: BinaryFloatingPoint>(_ value: T) -> T {
    value - floor(value)
}

// MARK: - Angle Utilities

/// Normalizes an angle to the range [0, 2π)
public func normalizeAngle(_ angle: Float) -> Float {
    let twoPi = Float.pi * 2
    var normalized = angle.truncatingRemainder(dividingBy: twoPi)
    if normalized < 0 {
        normalized += twoPi
    }
    return normalized
}

/// Normalizes an angle to the range [-π, π)
public func normalizeAngleSigned(_ angle: Float) -> Float {
    let twoPi = Float.pi * 2
    var normalized = angle.truncatingRemainder(dividingBy: twoPi)
    if normalized >= .pi {
        normalized -= twoPi
    } else if normalized < -.pi {
        normalized += twoPi
    }
    return normalized
}

/// Shortest angular difference between two angles
/// - Returns: Difference in range [-π, π]
public func angleDifference(_ a: Float, _ b: Float) -> Float {
    normalizeAngleSigned(a - b)
}

/// Converts degrees to radians
public func degreesToRadians(_ degrees: Float) -> Float {
    degrees * .pi / 180
}

/// Converts radians to degrees
public func radiansToDegrees(_ radians: Float) -> Float {
    radians * 180 / .pi
}

// MARK: - Easing Functions

/// Ease-in quadratic
public func easeInQuad<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * t
}

/// Ease-out quadratic
public func easeOutQuad<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * (2 - t)
}

/// Ease-in-out quadratic
public func easeInOutQuad<T: BinaryFloatingPoint>(_ t: T) -> T {
    t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t
}

/// Ease-in cubic
public func easeInCubic<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * t * t
}

/// Ease-out cubic
public func easeOutCubic<T: BinaryFloatingPoint>(_ t: T) -> T {
    let t1 = t - 1
    return t1 * t1 * t1 + 1
}

/// Ease-in-out cubic
public func easeInOutCubic<T: BinaryFloatingPoint>(_ t: T) -> T {
    if t < 0.5 {
        return 4 * t * t * t
    } else {
        let t1 = 2 * t - 2
        return 1 + t1 * t1 * t1 / 2
    }
}

/// Ease-in exponential (Float version)
public func easeInExpo(_ t: Float) -> Float {
    t == 0 ? 0 : Foundation.pow(2, 10 * (t - 1))
}

/// Ease-out exponential (Float version)
public func easeOutExpo(_ t: Float) -> Float {
    t == 1 ? 1 : 1 - Foundation.pow(2, -10 * t)
}

/// Ease-in-out exponential (Float version)
public func easeInOutExpo(_ t: Float) -> Float {
    if t == 0 || t == 1 { return t }
    if t < 0.5 {
        return Foundation.pow(2, 20 * t - 10) / 2
    } else {
        return (2 - Foundation.pow(2, -20 * t + 10)) / 2
    }
}

/// Ease-in exponential (Double version)
public func easeInExpo(_ t: Double) -> Double {
    t == 0 ? 0 : Foundation.pow(2, 10 * (t - 1))
}

/// Ease-out exponential (Double version)
public func easeOutExpo(_ t: Double) -> Double {
    t == 1 ? 1 : 1 - Foundation.pow(2, -10 * t)
}

/// Ease-in-out exponential (Double version)
public func easeInOutExpo(_ t: Double) -> Double {
    if t == 0 || t == 1 { return t }
    if t < 0.5 {
        return Foundation.pow(2, 20 * t - 10) / 2
    } else {
        return (2 - Foundation.pow(2, -20 * t + 10)) / 2
    }
}

// MARK: - Comparison Utilities

/// Checks if two floating-point values are approximately equal
public func isApproximatelyEqual<T: BinaryFloatingPoint>(_ a: T, _ b: T, epsilon: T = T(1e-5)) -> Bool {
    abs(a - b) < epsilon
}

/// Checks if a value is approximately zero
public func isApproximatelyZero<T: BinaryFloatingPoint>(_ value: T, epsilon: T = T(1e-5)) -> Bool {
    abs(value) < epsilon
}
