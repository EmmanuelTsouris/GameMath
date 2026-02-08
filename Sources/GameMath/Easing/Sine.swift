//
//  Sine.swift
//  GameMath
//
//  Sine easing functions
//  Based on Robert Penner's easing equations
//

import Foundation

/// Ease-in sine
public func easeInSine(_ t: Float) -> Float {
    sin((t - 1) * .pi / 2) + 1
}

/// Ease-out sine
public func easeOutSine(_ t: Float) -> Float {
    sin(t * .pi / 2)
}

/// Ease-in-out sine
public func easeInOutSine(_ t: Float) -> Float {
    0.5 * (1 - cos(t * .pi))
}

/// Ease-in sine (Double version)
public func easeInSine(_ t: Double) -> Double {
    sin((t - 1) * .pi / 2) + 1
}

/// Ease-out sine (Double version)
public func easeOutSine(_ t: Double) -> Double {
    sin(t * .pi / 2)
}

/// Ease-in-out sine (Double version)
public func easeInOutSine(_ t: Double) -> Double {
    0.5 * (1 - cos(t * .pi))
}
