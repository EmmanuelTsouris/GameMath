//
//  ExtremeBack.swift
//  GameMath
//
//  Extreme back (pronounced overshoot) easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in extreme back (pronounced overshoot)
public func easeInExtremeBack(_ t: Float) -> Float {
    (t * t - sin(t * .pi)) * t
}

/// Ease-out extreme back
public func easeOutExtremeBack(_ t: Float) -> Float {
    let f = 1 - t
    return 1 - (f * f - sin(f * .pi)) * f
}

/// Ease-in-out extreme back
public func easeInOutExtremeBack(_ t: Float) -> Float {
    if t < 0.5 {
        let f = 2 * t
        return 0.5 * (f * f - sin(f * .pi)) * f
    } else {
        let f = 2 * (1 - t)
        return 1 - 0.5 * (f * f - sin(f * .pi)) * f
    }
}

/// Ease-in extreme back (Double version)
public func easeInExtremeBack(_ t: Double) -> Double {
    (t * t - sin(t * .pi)) * t
}

/// Ease-out extreme back (Double version)
public func easeOutExtremeBack(_ t: Double) -> Double {
    let f = 1 - t
    return 1 - (f * f - sin(f * .pi)) * f
}

/// Ease-in-out extreme back (Double version)
public func easeInOutExtremeBack(_ t: Double) -> Double {
    if t < 0.5 {
        let f = 2 * t
        return 0.5 * (f * f - sin(f * .pi)) * f
    } else {
        let f = 2 * (1 - t)
        return 1 - 0.5 * (f * f - sin(f * .pi)) * f
    }
}
