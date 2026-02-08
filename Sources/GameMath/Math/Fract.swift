//
//  Fract.swift
//  GameMath
//

import Foundation

/// Returns the fractional part of a value
public func fract<T: BinaryFloatingPoint>(_ value: T) -> T {
    value - floor(value)
}
