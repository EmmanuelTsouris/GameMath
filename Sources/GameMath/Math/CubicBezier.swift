//
//  CubicBezier.swift
//  GameMath
//

import Foundation

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
