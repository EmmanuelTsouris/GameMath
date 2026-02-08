//
//  Cubic.swift
//  GameMath
//
//  Cubic easing functions
//

import Foundation

/// Ease-in cubic
public func easeInCubic<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * t * t
}

/// Ease-out cubic
public func easeOutCubic<T: BinaryFloatingPoint>(_ t: T) -> T {
    let t1 = t - 1
    return t1 * t1 * t1 + 1
}

/// Ease-in-out cubic
public func easeInOutCubic<T: BinaryFloatingPoint>(_ t: T) -> T {
    if t < 0.5 {
        return 4 * t * t * t
    } else {
        let t1 = 2 * t - 2
        return 1 + t1 * t1 * t1 / 2
    }
}
