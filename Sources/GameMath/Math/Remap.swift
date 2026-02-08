//
//  Remap.swift
//  GameMath
//

import Foundation

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
