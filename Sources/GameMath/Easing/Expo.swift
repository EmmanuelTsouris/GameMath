//
//  Expo.swift
//  GameMath
//
//  Exponential easing functions
//

import Foundation

/// Ease-in exponential (Float version)
public func easeInExpo(_ t: Float) -> Float {
    t == 0 ? 0 : Foundation.pow(2, 10 * (t - 1))
}

/// Ease-out exponential (Float version)
public func easeOutExpo(_ t: Float) -> Float {
    t == 1 ? 1 : 1 - Foundation.pow(2, -10 * t)
}

/// Ease-in-out exponential (Float version)
public func easeInOutExpo(_ t: Float) -> Float {
    if t == 0 || t == 1 { return t }
    if t < 0.5 {
        return Foundation.pow(2, 20 * t - 10) / 2
    } else {
        return (2 - Foundation.pow(2, -20 * t + 10)) / 2
    }
}

/// Ease-in exponential (Double version)
public func easeInExpo(_ t: Double) -> Double {
    t == 0 ? 0 : Foundation.pow(2, 10 * (t - 1))
}

/// Ease-out exponential (Double version)
public func easeOutExpo(_ t: Double) -> Double {
    t == 1 ? 1 : 1 - Foundation.pow(2, -10 * t)
}

/// Ease-in-out exponential (Double version)
public func easeInOutExpo(_ t: Double) -> Double {
    if t == 0 || t == 1 { return t }
    if t < 0.5 {
        return Foundation.pow(2, 20 * t - 10) / 2
    } else {
        return (2 - Foundation.pow(2, -20 * t + 10)) / 2
    }
}
