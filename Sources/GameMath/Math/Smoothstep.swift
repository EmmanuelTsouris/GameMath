//
//  Smoothstep.swift
//  GameMath
//

import Foundation

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
