//
//  RandomUtilsTests.swift
//  GameMath
//

import Testing
import Foundation
@testable import GameMath

@Test("SeededRandom produces consistent results")
func testSeededRandomConsistency() {
    var rng1 = SeededRandom(seed: 42)
    var rng2 = SeededRandom(seed: 42)

    // Same seed should produce same sequence
    for _ in 0..<10 {
        #expect(rng1.next() == rng2.next())
    }
}

@Test("SeededRandom nextFloat range")
func testSeededRandomFloatRange() {
    var rng = SeededRandom(seed: 42)

    for _ in 0..<100 {
        let value = rng.nextFloat()
        #expect(value >= 0 && value < 1)
    }
}

@Test("SeededRandom nextInt range")
func testSeededRandomIntRange() {
    var rng = SeededRandom(seed: 42)

    for _ in 0..<100 {
        let value = rng.nextInt(in: 0..<10)
        #expect(value >= 0 && value < 10)
    }
}

@Test("SeededRandom nextFloat in custom range")
func testSeededRandomFloatCustomRange() {
    var rng = SeededRandom(seed: 42)

    for _ in 0..<100 {
        let value = rng.nextFloat(in: 10..<20)
        #expect(value >= 10 && value < 20)
    }
}

@Test("SeededRandom shuffle")
func testSeededRandomShuffle() {
    var rng1 = SeededRandom(seed: 42)
    var rng2 = SeededRandom(seed: 42)

    let original = Array(1...10)
    var shuffled1 = original
    var shuffled2 = original

    rng1.shuffle(&shuffled1)
    rng2.shuffle(&shuffled2)

    // Same seed should produce same shuffle
    #expect(shuffled1 == shuffled2)

    // Should contain same elements
    #expect(Set(shuffled1) == Set(original))

    // Should be different order (extremely unlikely to be same)
    #expect(shuffled1 != original)
}

@Test("Vector2D random")
func testVector2DRandom() {
    var rng = SeededRandom(seed: 42)

    for _ in 0..<100 {
        let v = Vector2D.random(using: &rng)
        #expect(v.x >= 0 && v.x < 1)
        #expect(v.y >= 0 && v.y < 1)
    }
}

@Test("Vector2D random direction is normalized")
func testVector2DRandomDirection() {
    var rng = SeededRandom(seed: 42)

    for _ in 0..<100 {
        let v = Vector2D.randomDirection(using: &rng)
        #expect(abs(v.length - 1) < 0.0001)
    }
}

@Test("Vector3D random direction is normalized")
func testVector3DRandomDirection() {
    var rng = SeededRandom(seed: 42)

    for _ in 0..<100 {
        let v = Vector3D.randomDirection(using: &rng)
        #expect(abs(v.length - 1) < 0.0001)
    }
}

@Test("Global random helpers work")
func testGlobalRandomHelpers() {
    // These use system RNG, so just verify they don't crash and return valid ranges
    let f = randomFloat()
    #expect(f >= 0 && f < 1)

    let f2 = randomFloat(in: 10..<20)
    #expect(f2 >= 10 && f2 < 20)

    let i = randomInt(in: 0..<10)
    #expect(i >= 0 && i < 10)

    let _ = randomBool() // Just verify it doesn't crash

    let array = [1, 2, 3, 4, 5]
    if let element = randomElement(from: array) {
        #expect(array.contains(element))
    }
}
