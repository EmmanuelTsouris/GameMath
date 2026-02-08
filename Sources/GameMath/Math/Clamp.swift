//
//  Clamp.swift
//  GameMath
//

import Foundation

/// Clamps a value between min and max
/// - Parameters:
///   - value: Value to clamp
///   - min: Minimum value
///   - max: Maximum value
/// - Returns: Clamped value
public func clamp<T: Comparable>(_ value: T, _ min: T, _ max: T) -> T {
    Swift.max(min, Swift.min(max, value))
}
