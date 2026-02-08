//
//  RemapClamped.swift
//  GameMath
//

import Foundation

/// Remaps a value from one range to another and clamps the result
/// - Parameters:
///   - value: Value to remap
///   - from: Original range (min, max)
///   - to: Target range (min, max)
/// - Returns: Remapped and clamped value
public func remapClamped<T: BinaryFloatingPoint>(
    _ value: T,
    from: (T, T),
    to: (T, T)
) -> T {
    let remapped = remap(value, from: from.0, from.1, to: to.0, to.1)
    let minTo = min(to.0, to.1)
    let maxTo = max(to.0, to.1)
    return clamp(remapped, minTo, maxTo)
}
