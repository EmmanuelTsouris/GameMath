//
//  Lerp.swift
//  GameMath
//

import Foundation

/// Linear interpolation between two values
/// - Parameters:
///   - a: Start value
///   - b: End value
///   - t: Interpolation factor (0...1)
/// - Returns: Interpolated value
public func lerp<T: BinaryFloatingPoint>(_ a: T, _ b: T, _ t: T) -> T {
    a + (b - a) * t
}
