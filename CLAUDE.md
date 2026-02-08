# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## ⚠️ IMPORTANT: Public Repository

**This is a PUBLIC open-source repository.** Never include references to private projects, proprietary code, internal tooling, credentials, or any non-public information.

## Project Overview

GameMath is a pure Swift math library for game development with these requirements:

- **Foundation-only**: No UIKit, AppKit, or SpriteKit imports
- **Cross-platform**: Must work on macOS, iOS, tvOS, visionOS, AND Linux
- **SIMD-backed**: Vector types use Swift's built-in SIMD for performance
- **Zero dependencies**: No external packages
- **Sendable-safe**: All types must be Sendable (Swift 6.2 strict concurrency)

## Building and Testing

```bash
# Build and run all tests
swift build -v
swift test -v

# Run specific tests
swift test --filter Vector2DTests
swift test --filter testVector2DInit
```

Tests use swift-testing framework (`@Test`, `#expect`) not XCTest. Must pass on both macOS and Linux.

## Architecture

### SIMD-Based Vector System

The core design uses Swift's `SIMD2<Float>` and `SIMD3<Float>` types directly:

- **Vector2D** and **Vector3D** are typealiases to `SIMD2<Float>` and `SIMD3<Float>`
- **SIMDExtensions.swift**: Extensions on SIMD types providing all vector operations
- All operations leverage SIMD hardware acceleration automatically

**When adding vector operations:**
1. Add extension methods on `SIMD2<Float>` or `SIMD3<Float>` in SIMDExtensions.swift
2. Use Swift's standard library SIMD types (not platform-specific simd framework)
3. Mark operations `@inlinable` for performance when appropriate

### Module Organization

Core files:
- **SIMDExtensions.swift**: Vector2D/Vector3D typealiases and all SIMD operations
- **AABB.swift**, **Circle.swift**, **Ray.swift**: Collision detection primitives
- **RandomUtils.swift**: Seeded RNG (Xorshift64*) for deterministic gameplay

Utility functions (one per file):
- **Math/** subdirectory: Lerp, Smoothstep, CubicBezier, Clamp, Remap, Fract, Angle utilities, ApproximateEquality, Sign
- **Easing/** subdirectory: Quad, Cubic, Quartic, Quintic, Sine, Circular, Expo, Elastic, Back, ExtremeBack, Bounce

**Pattern**: Math utilities are split into individual files (one function per file) to keep files small and focused.

## File Size Rules

Maximum 200 lines per Swift file. If a file approaches 200 lines, split it.

Split strategy:
- Math utility functions: one function per file (see Math/ and Easing/ subdirectories)
- Extensions go in separate files (`TypeName+Context.swift`)
- One type per file. One protocol per file
- Tests mirror source structure

Why: Every file in this repo will be read by AI agents. A 1000-line file
burns context window on code irrelevant to the current task. Five 200-line
files let the agent load only what it needs.

Hard rule: If `wc -l` on any Swift file exceeds 250, the PR is rejected.

**Example**: MathUtils.swift was split into Math/Lerp.swift, Math/Clamp.swift, Math/Remap.swift, etc.

## Key Guidelines

- Test edge cases: zero vectors, divide by zero, NaN, infinity, negative values
- Use provided angle utilities (`normalizeAngle`, `normalizeAngleSigned`) not manual modulo
- Document public APIs with DocC-style comments (`///`)
- Use conventional commit prefixes: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `perf:`
- All types must conform to `Sendable` for Swift 6.2 strict concurrency
- Mark performance-critical operations `@inlinable`
- May be appropriate if a real consumer needs it: polygon collision, perlin noise, quaternions, matrix types
- Requires: at least one active project blocked without it before adding
- Not appropriate: platform-specific code, networking, UI components, third-party deps

## Common Patterns

**Vector creation:**
```swift
let v = Vector2D(x: 3, y: 4)  // Labeled initializer
let v = SIMD2<Float>(3, 4)    // Also works (same type)
```

**Collision types:**
All collision types (AABB, Circle, Ray) are structs conforming to `Sendable, Hashable, Codable`.

**Math utilities:**
Prefer generic `BinaryFloatingPoint` constraints for utilities that work with Float and Double:
```swift
public func lerp<T: BinaryFloatingPoint>(_ a: T, _ b: T, _ t: T) -> T
```

## GameMath Scope

This is a primitives library: lerp, clamp, remap, easing, SIMD,
basic geometry.

Do NOT add:
- Game-specific formulas (economy, prestige, scoring)
- Shape generators (star polygons, hex grids) unless 3+ consumers
- Wrappers around things Swift already provides
- Types that duplicate SIMD functionality

When in doubt, leave it in the game code.
