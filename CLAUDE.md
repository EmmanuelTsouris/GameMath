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

The core design wraps Swift's `SIMD2<Float>` and `SIMD3<Float>` types:

- **Vector2D/Vector3D**: Public API with convenient properties (`.x`, `.y`, `.z`)
- **SIMDExtensions.swift**: Cross-platform SIMD operations (`.length`, `.dot()`, `.cross()`, `.mix()`, `.reflect()`)
- All vector operations delegate to SIMD for hardware acceleration

**When adding vector operations:**
1. Implement on SIMD types in SIMDExtensions.swift
2. Expose via Vector2D/Vector3D public API
3. Use Swift's standard library SIMD (not platform-specific simd framework)

### Module Organization

- **Vector2D.swift** / **Vector3D.swift**: SIMD-backed vector types
- **SIMDExtensions.swift**: Cross-platform SIMD operations
- **AABB.swift**: Axis-aligned bounding box collision
- **Circle.swift**: Circle collision primitives
- **Ray.swift**: Ray casting and intersection tests
- **MathUtils.swift**: Interpolation, easing, angle utilities, clamping, remapping
- **RandomUtils.swift**: Seeded RNG (Xorshift64*) for deterministic gameplay

## Key Guidelines

- Test edge cases: zero vectors, divide by zero, NaN, infinity, negative values
- Use provided angle utilities (`normalizeAngle`, `normalizeAngleSigned`) not manual modulo
- Document public APIs with DocC-style comments
- Use conventional commit prefixes: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `perf:`
- Appropriate additions: polygon collision, perlin noise, quaternions
- Not appropriate: platform-specific code, networking, UI components, third-party deps
