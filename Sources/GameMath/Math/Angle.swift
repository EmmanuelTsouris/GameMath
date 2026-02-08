//
//  Angle.swift
//  GameMath
//

import Foundation

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
