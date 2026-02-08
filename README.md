# GameMath

Pure Swift math library for game development with zero platform dependencies.

[![CI](https://github.com/EmmanuelTsouris/GameMath/actions/workflows/ci.yml/badge.svg)](https://github.com/EmmanuelTsouris/GameMath/actions/workflows/ci.yml)
[![Swift](https://img.shields.io/badge/Swift-6.2-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%20|%20macOS%20|%20tvOS%20|%20visionOS%20|%20Linux-lightgray.svg)](https://swift.org)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Features

- ✅ **SIMD-backed vector types** (Vector2D, Vector3D) using Swift's built-in SIMD for high performance
- ✅ **Collision detection** primitives (AABB, Circle, Ray)
- ✅ **Interpolation utilities** (lerp, smoothstep, cubic bezier, easing functions)
- ✅ **Seeded random generation** for deterministic gameplay
- ✅ **Math helpers** (clamping, remapping, angle normalization)
- ✅ **Swift 6.2 strict concurrency** - all types are Sendable
- ✅ **Cross-platform** - works on iOS, macOS, tvOS, visionOS, and Linux

## Installation

### Swift Package Manager

Add GameMath to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/EmmanuelTsouris/GameMath", from: "1.0.0")
]
```

Or in Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/EmmanuelTsouris/GameMath`

## Quick Start

```swift
import GameMath

// Vector math
let v1 = Vector2D(x: 3, y: 4)
let v2 = Vector2D(x: 1, y: 2)
let sum = v1 + v2  // Vector2D(x: 4, y: 6)
let distance = v1.distance(to: v2)  // 2.828...

// Collision detection
let circle = Circle(center: .zero, radius: 5)
let aabb = AABB(center: .zero, size: Vector2D(x: 10, y: 10))
let isHit = circle.intersects(aabb)  // true

// Raycasting
let ray = Ray(origin: Vector2D(x: -10, y: 0), direction: .right)
if let distance = ray.intersects(circle) {
    print("Hit at distance: \(distance)")
}

// Interpolation
let lerped = lerp(0.0, 10.0, 0.5)  // 5.0
let smoothed = smoothstep(0.0, 10.0, 0.5)  // Ease-in-out

// Seeded random (deterministic)
var rng = SeededRandom(seed: 42)
let randomVec = Vector2D.random(using: &rng)
let randomDirection = Vector2D.randomDirection(using: &rng)
```

## Documentation

### Vector Math

```swift
// Create vectors
let v = Vector2D(x: 3, y: 4)
let v3d = Vector3D(x: 1, y: 2, z: 3)

// Common vectors
Vector2D.zero, .right, .up, .left, .down, .one
Vector3D.zero, .right, .up, .forward, .left, .down, .back, .one

// Operations
let length = v.length
let normalized = v.normalized
let dot = v1.dot(v2)
let cross = v1.cross(v2)  // Returns scalar for 2D, Vector3D for 3D
let lerped = v1.lerp(to: v2, t: 0.5)

// Create from angle
let v = Vector2D.fromAngle(.pi / 4, length: 10)
```

### Collision Detection

```swift
// AABB (Axis-Aligned Bounding Box)
let aabb = AABB(center: Vector2D(x: 5, y: 5), size: Vector2D(x: 10, y: 10))
aabb.contains(point)
aabb.intersects(otherAABB)
aabb.intersection(with: otherAABB)

// Circle
let circle = Circle(center: .zero, radius: 5)
circle.contains(point)
circle.intersects(otherCircle)
circle.intersects(aabb)

// Ray
let ray = Ray(origin: .zero, direction: .right)
ray.intersects(circle)  // Returns distance or nil
ray.intersects(aabb)
ray.intersects(otherRay)
```

### Interpolation

```swift
// Linear interpolation
lerp(0.0, 10.0, 0.5)  // 5.0

// Smooth interpolation (ease-in-out)
smoothstep(0.0, 10.0, 0.5)
smootherstep(0.0, 10.0, 0.5)  // Even smoother

// Cubic bezier
cubicBezier(0.0, 3.0, 7.0, 10.0, t: 0.5)

// Easing functions (based on Robert Penner's equations)
easeInQuad(t), easeOutQuad(t), easeInOutQuad(t)
easeInCubic(t), easeOutCubic(t), easeInOutCubic(t)
easeInQuartic(t), easeOutQuartic(t), easeInOutQuartic(t)
easeInQuintic(t), easeOutQuintic(t), easeInOutQuintic(t)
easeInSine(t), easeOutSine(t), easeInOutSine(t)
easeInCircular(t), easeOutCircular(t), easeInOutCircular(t)
easeInExpo(t), easeOutExpo(t), easeInOutExpo(t)
easeInElastic(t), easeOutElastic(t), easeInOutElastic(t)
easeInBack(t), easeOutBack(t), easeInOutBack(t)
easeInExtremeBack(t), easeOutExtremeBack(t), easeInOutExtremeBack(t)
easeInBounce(t), easeOutBounce(t), easeInOutBounce(t)
```

### Math Utilities

```swift
// Clamping and mapping
clamp(value, min, max)
remap(value, from: 0, 10, to: 100, 200)

// Angle utilities
normalizeAngle(angle)  // [0, 2π)
normalizeAngleSigned(angle)  // [-π, π)
angleDifference(a, b)
degreesToRadians(180)  // π
radiansToDegrees(.pi)  // 180

// Comparison
isApproximatelyEqual(a, b, epsilon: 0.0001)
isApproximatelyZero(value)

// Sign utilities
sign(value)  // Returns 1.0 or -1.0
randomSign()  // Random 1.0 or -1.0
```

### Random Generation

```swift
// Seeded random (deterministic)
var rng = SeededRandom(seed: 42)
let f = rng.nextFloat()  // [0, 1)
let i = rng.nextInt(in: 0..<10)
let b = rng.nextBool()

// Random vectors
Vector2D.random(using: &rng)
Vector2D.randomDirection(using: &rng)  // Unit vector
Vector3D.randomDirection(using: &rng)

// Shuffle arrays
var array = [1, 2, 3, 4, 5]
rng.shuffle(&array)

// Global helpers (uses system RNG)
randomFloat()
randomInt(in: 0..<10)
randomBool()
```

## Requirements

- Swift 6.2+
- iOS 26.2+ / macOS 26.2+ / tvOS 26.2+ / visionOS 26.2+ / Linux
- Xcode 26.3+ (for Apple platforms)

## Why GameMath?

- **Foundation-only**: No UIKit, AppKit, or SpriteKit dependencies
- **SIMD-optimized**: Uses Swift's built-in SIMD types for high performance
- **Cross-platform**: Works on all Apple platforms plus Linux
- **Deterministic**: Seeded RNG ensures reproducible gameplay
- **Sendable-safe**: Full Swift 6.2 concurrency support
- **Well-tested**: Comprehensive test suite with swift-testing

## Credits

GameMath includes easing functions adapted from:
- **Robert Penner's Easing Equations** (http://robertpenner.com/easing/)
- **Razeware LLC's SKTUtils** (MIT License) - https://github.com/raywenderlich/SKTUtils

Thank you to the open-source community for these battle-tested implementations!

## Contributing

GameMath is open-source! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Important**: This is a public open-source package. Do not reference private projects or proprietary code in contributions.

## License

MIT License - See [LICENSE](LICENSE) for details.

## Related Packages

GameMath works great with other open-source Swift packages:

- **[UXKit](https://github.com/EmmanuelTsouris/UXKit)** - Cross-platform type bridging (UXColor, UXImage, UXFont)

---

**Made with ❤️ for indie game developers**
