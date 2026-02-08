//
//  RemapClamped.swift
//  GameMath
//

import Foundation

/// Remaps a value from one range to another and clamps the result
///
/// This is a convenience wrapper combining `remap()` and `clamp()` for the common
/// pattern of range conversion with boundary enforcement. Useful when you need to
/// ensure the output stays within the target range even if the input overshoots.
///
/// - Parameters:
///   - value: Value to remap
///   - from: Original range (min, max) - order doesn't matter
///   - to: Target range (min, max) - order doesn't matter
/// - Returns: Remapped and clamped value
///
/// **Examples:**
/// ```swift
/// // Normal remapping
/// remapClamped(50, from: (0, 100), to: (0, 1))    // 0.5
///
/// // Clamping overshoot
/// remapClamped(150, from: (0, 100), to: (0, 1))   // 1.0 (clamped)
/// remapClamped(-50, from: (0, 100), to: (0, 1))   // 0.0 (clamped)
///
/// // Reverse ranges work correctly
/// remapClamped(75, from: (0, 100), to: (1, 0))    // 0.25
/// remapClamped(25, from: (100, 0), to: (0, 1))    // 0.75
/// ```
///
/// **Edge Cases:**
/// - Zero-width source range (e.g., `from: (50, 50)`): Produces `NaN` in remap, which becomes max of target range after clamping
/// - Zero-width target range (e.g., `to: (5, 5)`): Returns the constant target value (5)
/// - Negative ranges work normally: `from: (-100, 0)` is valid
/// - For zero-width source ranges, consider guarding with a check if deterministic behavior is needed
@inlinable
public func remapClamped<T: BinaryFloatingPoint>(
    _ value: T,
    from: (T, T),
    to: (T, T)
) -> T {
    let remapped = remap(value, from: from.0, from.1, to: to.0, to.1)
    let minTo = min(to.0, to.1)
    let maxTo = max(to.0, to.1)
    return clamp(remapped, minTo, maxTo)
}
