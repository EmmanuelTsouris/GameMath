//
//  Elastic.swift
//  GameMath
//
//  Elastic (springy) easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in elastic (springy overshoot)
public func easeInElastic(_ t: Float) -> Float {
    sin(13 * .pi / 2 * t) * Foundation.pow(2, 10 * (t - 1))
}

/// Ease-out elastic
public func easeOutElastic(_ t: Float) -> Float {
    sin(-13 * .pi / 2 * (t + 1)) * Foundation.pow(2, -10 * t) + 1
}

/// Ease-in-out elastic
public func easeInOutElastic(_ t: Float) -> Float {
    if t < 0.5 {
        return 0.5 * sin(13 * .pi * t) * Foundation.pow(2, 20 * t - 10)
    } else {
        return 0.5 * sin(-13 * .pi * t) * Foundation.pow(2, -20 * t + 10) + 1
    }
}

/// Ease-in elastic (Double version)
public func easeInElastic(_ t: Double) -> Double {
    sin(13 * .pi / 2 * t) * Foundation.pow(2, 10 * (t - 1))
}

/// Ease-out elastic (Double version)
public func easeOutElastic(_ t: Double) -> Double {
    sin(-13 * .pi / 2 * (t + 1)) * Foundation.pow(2, -10 * t) + 1
}

/// Ease-in-out elastic (Double version)
public func easeInOutElastic(_ t: Double) -> Double {
    if t < 0.5 {
        return 0.5 * sin(13 * .pi * t) * Foundation.pow(2, 20 * t - 10)
    } else {
        return 0.5 * sin(-13 * .pi * t) * Foundation.pow(2, -20 * t + 10) + 1
    }
}
