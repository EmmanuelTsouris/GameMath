//
//  Quad.swift
//  GameMath
//
//  Quadratic easing functions
//

import Foundation

/// Ease-in quadratic
public func easeInQuad<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * t
}

/// Ease-out quadratic
public func easeOutQuad<T: BinaryFloatingPoint>(_ t: T) -> T {
    t * (2 - t)
}

/// Ease-in-out quadratic
public func easeInOutQuad<T: BinaryFloatingPoint>(_ t: T) -> T {
    t < 0.5 ? 2 * t * t : -1 + (4 - 2 * t) * t
}
