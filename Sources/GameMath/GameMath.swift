//
//  GameMath.swift
//  GameMath
//
//  Pure Swift math library for game development
//
//  ## Features
//
//  - **Vector Math**: SIMD-backed Vector2D and Vector3D types
//  - **Collision Detection**: AABB, Circle, and Ray intersection tests
//  - **Interpolation**: lerp, smoothstep, cubic bezier, easing functions
//  - **Random Utilities**: Seeded RNG for deterministic randomness
//  - **Math Helpers**: Clamping, remapping, angle normalization
//
//  ## Platform Support
//
//  - iOS 26.2+, macOS 26.2+, tvOS 26.2+, visionOS 26.2+, Linux
//  - Swift 6.2+ with strict concurrency
//  - Foundation-only (no platform-specific dependencies)
//
//  ## Usage
//
//  ```swift
//  import GameMath
//
//  // Vector math
//  let v1 = Vector2D(x: 3, y: 4)
//  let v2 = Vector2D(x: 1, y: 2)
//  let sum = v1 + v2
//  let distance = v1.distance(to: v2)
//
//  // Collision detection
//  let circle = Circle(center: .zero, radius: 5)
//  let aabb = AABB(center: .zero, size: Vector2D(x: 10, y: 10))
//  let hit = circle.intersects(aabb)
//
//  // Interpolation
//  let lerped = lerp(0.0, 10.0, 0.5) // 5.0
//  let smoothed = smoothstep(0.0, 10.0, 0.5) // Ease-in-out
//
//  // Random generation
//  var rng = SeededRandom(seed: 42)
//  let randomVec = Vector2D.random(using: &rng)
//  ```
//

import Foundation

// Re-export all public types
// (All types are already public in their respective files)

/// Current version of GameMath
public let gameMathVersion = "1.1.0"
