//
//  MathUtilsTests.swift
//  GameMath
//

import Testing
import Foundation
@testable import GameMath

@Test("lerp interpolation")
func testLerp() {
    #expect(lerp(0.0, 10.0, 0.0) == 0.0)
    #expect(lerp(0.0, 10.0, 0.5) == 5.0)
    #expect(lerp(0.0, 10.0, 1.0) == 10.0)
}

@Test("smoothstep interpolation")
func testSmoothstep() {
    let result = smoothstep(0.0, 10.0, 0.5)
    #expect(result == 5.0) // Should be exactly 0.5 after smoothing

    // Should clamp to range
    #expect(smoothstep(0.0, 10.0, -0.5) == 0.0)
    #expect(smoothstep(0.0, 10.0, 1.5) == 10.0)
}

@Test("clamp function")
func testClamp() {
    #expect(clamp(5, 0, 10) == 5)
    #expect(clamp(-5, 0, 10) == 0)
    #expect(clamp(15, 0, 10) == 10)
}

@Test("remap function")
func testRemap() {
    // Remap 5 from [0, 10] to [0, 100]
    #expect(remap(5.0, from: 0, 10, to: 0, 100) == 50.0)

    // Remap 0 from [0, 10] to [50, 100]
    #expect(remap(0.0, from: 0, 10, to: 50, 100) == 50.0)

    // Remap 10 from [0, 10] to [50, 100]
    #expect(remap(10.0, from: 0, 10, to: 50, 100) == 100.0)
}

@Test("remapClamped function")
func testRemapClamped() {
    // Basic remapping
    #expect(remapClamped(25.0, from: (0, 100), to: (0, 1)) == 0.25)

    // Upper bound clamping
    #expect(remapClamped(150.0, from: (0, 100), to: (0, 1)) == 1.0)

    // Lower bound clamping
    #expect(remapClamped(-50.0, from: (0, 100), to: (0, 1)) == 0.0)

    // Reverse target range
    #expect(remapClamped(75.0, from: (0, 100), to: (1, 0)) == 0.25)

    // Reverse source range
    #expect(remapClamped(25.0, from: (100, 0), to: (0, 1)) == 0.75)

    // Negative ranges
    #expect(remapClamped(-50.0, from: (-100, 0), to: (0, 1)) == 0.5)
    #expect(remapClamped(-75.0, from: (-100, 0), to: (0, 1)) == 0.25)

    // Zero-width target range (should return constant)
    #expect(remapClamped(50.0, from: (0, 100), to: (5, 5)) == 5.0)

    // Zero-width source range (NaN becomes max after clamp)
    #expect(remapClamped(50.0, from: (50, 50), to: (0, 1)) == 1.0)
    #expect(remapClamped(100.0, from: (100, 100), to: (-5, 5)) == 5.0)
}

@Test("fract function")
func testFract() {
    #expect(abs(fract(3.14) - 0.14) < 0.0001)
    #expect(fract(5.0) == 0.0)
    #expect(abs(fract(-2.3) - 0.7) < 0.0001)
}

@Test("angle normalization")
func testNormalizeAngle() {
    #expect(normalizeAngle(0) == 0)
    #expect(abs(normalizeAngle(.pi * 2) - 0) < 0.0001)
    #expect(abs(normalizeAngle(.pi * 3) - .pi) < 0.0001)
    #expect(abs(normalizeAngle(-.pi) - .pi) < 0.0001)
}

@Test("signed angle normalization")
func testNormalizeAngleSigned() {
    #expect(normalizeAngleSigned(0) == 0)

    // π and -π are equivalent, so check for either
    let piResult = normalizeAngleSigned(.pi)
    #expect(abs(piResult - .pi) < 0.0001 || abs(piResult + .pi) < 0.0001)

    let negPiResult = normalizeAngleSigned(-.pi)
    #expect(abs(negPiResult - .pi) < 0.0001 || abs(negPiResult + .pi) < 0.0001)
}

@Test("angle difference")
func testAngleDifference() {
    #expect(abs(angleDifference(0, 0)) < 0.0001)
    #expect(abs(angleDifference(.pi, 0) - .pi) < 0.0001 || abs(angleDifference(.pi, 0) + .pi) < 0.0001)
}

@Test("degrees/radians conversion")
func testDegreeRadianConversion() {
    #expect(abs(degreesToRadians(180) - .pi) < 0.0001)
    #expect(abs(radiansToDegrees(.pi) - 180) < 0.0001)
    #expect(abs(degreesToRadians(90) - (.pi / 2)) < 0.0001)
}

@Test("easing functions")
func testEasingFunctions() {
    // All easing functions should map [0, 1] to [0, 1]
    #expect(easeInQuad(0.0) == 0.0)
    #expect(easeInQuad(1.0) == 1.0)

    #expect(easeOutQuad(0.0) == 0.0)
    #expect(easeOutQuad(1.0) == 1.0)

    #expect(easeInOutQuad(0.0) == 0.0)
    #expect(easeInOutQuad(1.0) == 1.0)

    #expect(easeInCubic(0.0) == 0.0)
    #expect(easeInCubic(1.0) == 1.0)

    #expect(easeOutCubic(0.0) == 0.0)
    #expect(easeOutCubic(1.0) == 1.0)

    #expect(easeInOutCubic(0.0) == 0.0)
    #expect(easeInOutCubic(1.0) == 1.0)

    // Quartic
    #expect(easeInQuartic(0.0) == 0.0)
    #expect(easeInQuartic(1.0) == 1.0)

    #expect(easeOutQuartic(0.0) == 0.0)
    #expect(easeOutQuartic(1.0) == 1.0)

    // Quintic
    #expect(easeInQuintic(0.0) == 0.0)
    #expect(easeInQuintic(1.0) == 1.0)

    // Sine
    #expect(abs(easeInSine(0.0)) < 0.0001)
    #expect(abs(easeInSine(1.0) - 1.0) < 0.0001)

    #expect(abs(easeOutSine(0.0)) < 0.0001)
    #expect(abs(easeOutSine(1.0) - 1.0) < 0.0001)

    // Circular
    #expect(abs(easeInCircular(0.0)) < 0.0001)
    #expect(abs(easeInCircular(1.0) - 1.0) < 0.0001)

    // Back
    #expect(easeInBack(0.0) == 0.0)
    #expect(abs(easeInBack(1.0) - 1.0) < 0.0001)

    // Bounce
    #expect(abs(easeOutBounce(0.0)) < 0.0001)
    #expect(abs(easeOutBounce(1.0) - 1.0) < 0.0001)
}

@Test("sign function")
func testSign() {
    #expect(sign(5.0) == 1.0)
    #expect(sign(-5.0) == -1.0)
    #expect(sign(0.0) == 1.0)
}

@Test("randomSign function")
func testRandomSign() {
    // Test that randomSign returns either 1 or -1
    for _ in 0..<100 {
        let value = randomSign()
        #expect(value == 1.0 || value == -1.0)
    }
}

@Test("approximate equality")
func testApproximateEquality() {
    #expect(isApproximatelyEqual(1.0, 1.0000001))
    #expect(!isApproximatelyEqual(1.0, 1.1))

    #expect(isApproximatelyZero(0.0000001))
    #expect(!isApproximatelyZero(0.1))
}

@Test("cubic bezier")
func testCubicBezier() {
    // At t=0, should be p0
    #expect(cubicBezier(0.0, 1.0, 2.0, 3.0, 0.0) == 0.0)

    // At t=1, should be p3
    #expect(cubicBezier(0.0, 1.0, 2.0, 3.0, 1.0) == 3.0)

    // At t=0.5, should be between p0 and p3
    let mid = cubicBezier(0.0, 1.0, 2.0, 3.0, 0.5)
    #expect(mid > 0 && mid < 3)
}
