//
//  ApproximateEquality.swift
//  GameMath
//

import Foundation

/// Checks if two floating-point values are approximately equal
public func isApproximatelyEqual<T: BinaryFloatingPoint>(_ a: T, _ b: T, epsilon: T = T(1e-5)) -> Bool {
    abs(a - b) < epsilon
}

/// Checks if a value is approximately zero
public func isApproximatelyZero<T: BinaryFloatingPoint>(_ value: T, epsilon: T = T(1e-5)) -> Bool {
    abs(value) < epsilon
}
