//
//  Back.swift
//  GameMath
//
//  Back (overshoot) easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in back (slight overshoot)
public func easeInBack<T: BinaryFloatingPoint>(_ t: T) -> T {
    let s: T = 1.70158
    return ((s + 1) * t - s) * t * t
}

/// Ease-out back
public func easeOutBack<T: BinaryFloatingPoint>(_ t: T) -> T {
    let s: T = 1.70158
    let f = 1 - t
    return 1 - ((s + 1) * f - s) * f * f
}

/// Ease-in-out back
public func easeInOutBack<T: BinaryFloatingPoint>(_ t: T) -> T {
    let s: T = 1.70158
    if t < 0.5 {
        let f = 2 * t
        return 0.5 * ((s + 1) * f - s) * f * f
    } else {
        let f = 2 * (1 - t)
        return 1 - 0.5 * ((s + 1) * f - s) * f * f
    }
}
