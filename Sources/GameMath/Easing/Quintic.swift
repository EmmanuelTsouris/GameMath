//
//  Quintic.swift
//  GameMath
//
//  Quintic (5th power) easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in quintic (5th power)
public func easeInQuintic<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * t * t * t * t
}

/// Ease-out quintic
public func easeOutQuintic<T: BinaryFloatingPoint>(_ t: T) -> T {
    let f = t - 1
    return 1 + f * f * f * f * f
}

/// Ease-in-out quintic
public func easeInOutQuintic<T: BinaryFloatingPoint>(_ t: T) -> T {
    if t < 0.5 {
        return 16 * t * t * t * t * t
    } else {
        let f = t - 1
        return 1 + 16 * f * f * f * f * f
    }
}
