//
//  Sign.swift
//  GameMath
//

import Foundation

/// Returns the sign of a value (1 if positive or zero, -1 if negative)
public func sign<T: BinaryFloatingPoint & SignedNumeric>(_ value: T) -> T {
    value >= 0 ? 1 : -1
}

/// Returns a random sign (1 or -1) with equal probability
public func randomSign() -> Float {
    Float.random(in: 0..<1) < 0.5 ? 1 : -1
}

/// Returns a random sign (1 or -1) with equal probability (Double version)
public func randomSignDouble() -> Double {
    Double.random(in: 0..<1) < 0.5 ? 1 : -1
}
