//
//  Bounce.swift
//  GameMath
//
//  Bounce (bouncing ball) easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in bounce (bouncing ball effect)
public func easeInBounce<T: BinaryFloatingPoint>(_ t: T) -> T {
    1 - easeOutBounce(1 - t)
}

/// Ease-out bounce
public func easeOutBounce<T: BinaryFloatingPoint>(_ t: T) -> T {
    if t < 1 / 2.75 {
        return 7.5625 * t * t
    } else if t < 2 / 2.75 {
        let f = t - 1.5 / 2.75
        return 7.5625 * f * f + 0.75
    } else if t < 2.5 / 2.75 {
        let f = t - 2.25 / 2.75
        return 7.5625 * f * f + 0.9375
    } else {
        let f = t - 2.625 / 2.75
        return 7.5625 * f * f + 0.984375
    }
}

/// Ease-in-out bounce
public func easeInOutBounce<T: BinaryFloatingPoint>(_ t: T) -> T {
    if t < 0.5 {
        return 0.5 * easeInBounce(t * 2)
    } else {
        return 0.5 * easeOutBounce(t * 2 - 1) + 0.5
    }
}
