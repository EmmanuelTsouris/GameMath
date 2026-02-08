//
//  Quartic.swift
//  GameMath
//
//  Quartic (4th power) easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in quartic (4th power)
public func easeInQuartic<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * t * t * t
}

/// Ease-out quartic
public func easeOutQuartic<T: BinaryFloatingPoint>(_ t: T) -> T {
    let f = t - 1
    return 1 - f * f * f * f
}

/// Ease-in-out quartic
public func easeInOutQuartic<T: BinaryFloatingPoint>(_ t: T) -> T {
    if t < 0.5 {
        return 8 * t * t * t * t
    } else {
        let f = t - 1
        return 1 - 8 * f * f * f * f
    }
}
