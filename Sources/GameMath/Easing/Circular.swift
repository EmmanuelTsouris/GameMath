//
//  Circular.swift
//  GameMath
//
//  Circular easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in circular
public func easeInCircular(_ t: Float) -> Float {
    1 - sqrt(1 - t * t)
}

/// Ease-out circular
public func easeOutCircular(_ t: Float) -> Float {
    sqrt((2 - t) * t)
}

/// Ease-in-out circular
public func easeInOutCircular(_ t: Float) -> Float {
    if t < 0.5 {
        return 0.5 * (1 - sqrt(1 - 4 * t * t))
    } else {
        return 0.5 * sqrt(-4 * t * t + 8 * t - 3) + 0.5
    }
}

/// Ease-in circular (Double version)
public func easeInCircular(_ t: Double) -> Double {
    1 - sqrt(1 - t * t)
}

/// Ease-out circular (Double version)
public func easeOutCircular(_ t: Double) -> Double {
    sqrt((2 - t) * t)
}

/// Ease-in-out circular (Double version)
public func easeInOutCircular(_ t: Double) -> Double {
    if t < 0.5 {
        return 0.5 * (1 - sqrt(1 - 4 * t * t))
    } else {
        return 0.5 * sqrt(-4 * t * t + 8 * t - 3) + 0.5
    }
}
