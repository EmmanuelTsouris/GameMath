# Contributing to GameMath

Thank you for your interest in contributing to GameMath! This document provides guidelines for contributing to this open-source project.

## Important: Public Open-Source Package

**GameMath is a public open-source package.** All contributions must follow these rules:

- ❌ **DO NOT** reference private projects, proprietary code, or internal tooling
- ❌ **DO NOT** include code from closed-source projects
- ✅ **DO** write code that is useful for the general game development community
- ✅ **DO** ensure all code is Foundation-only (no UIKit/AppKit/SpriteKit)
- ✅ **DO** maintain Linux compatibility

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/YOUR_USERNAME/GameMath.git`
3. Create a branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Run tests: `swift test`
6. Commit: `git commit -m "feat: add your feature"`
7. Push: `git push origin feature/your-feature-name`
8. Open a Pull Request

## Development Requirements

- Swift 6.2+
- Xcode 26.3+ (for Apple platforms)
- Linux (optional, for testing Linux compatibility)

## Code Guidelines

### Swift Style

- Use Swift 6.2 language mode
- Enable strict concurrency
- All public types must be `Sendable`
- Follow Swift API Design Guidelines
- Use meaningful variable names
- Add documentation comments for public APIs

### Architecture Rules

- **Foundation-only**: No UIKit, AppKit, or SpriteKit imports
- **Linux-compatible**: Code must compile on Linux
- **SIMD-based**: Use SIMD for vector math where possible
- **Pure functions**: Prefer immutability and pure functions
- **Zero dependencies**: No external package dependencies

### Testing

- Use `swift-testing` framework (`@Test`, `#expect`)
- Write tests for all new functionality
- Include edge cases (divide by zero, NaN, infinity, negative values)
- Maintain >80% code coverage
- Tests must pass on macOS AND Linux

### Documentation

- Add DocC-style documentation comments to all public APIs
- Include usage examples in documentation
- Update README.md if adding major features
- Keep CONTRIBUTING.md up to date

## What to Contribute

### Welcome Contributions

- Bug fixes
- Performance improvements
- Additional math utilities
- More easing functions
- Better collision detection algorithms
- Documentation improvements
- Test coverage improvements

### Examples of Good Contributions

```swift
// Add 2D polygon collision detection
public struct Polygon: Sendable, Hashable, Codable {
    public let vertices: [Vector2D]

    public func contains(_ point: Vector2D) -> Bool {
        // SAT algorithm implementation
    }
}

// Add perlin noise generation
public func perlinNoise(x: Float, y: Float, seed: UInt64) -> Float {
    // Perlin noise implementation
}

// Add quaternion type for 3D rotations
public struct Quaternion: Sendable, Hashable, Codable {
    // Quaternion implementation
}
```

### Not Appropriate for GameMath

- Platform-specific code (use UXKit instead)
- SpriteKit extensions (use  instead)
- SwiftUI components (use  instead)
- Networking, persistence, or I/O utilities
- Third-party dependencies

## Pull Request Process

1. **Run tests**: `swift test` must pass
2. **Check Linux compatibility**: If possible, test on Linux
3. **Update documentation**: Add/update documentation for new features
4. **Follow commit conventions**:
   - `feat:` - New features
   - `fix:` - Bug fixes
   - `docs:` - Documentation changes
   - `test:` - Test additions/changes
   - `refactor:` - Code refactoring
   - `perf:` - Performance improvements

5. **PR description should include**:
   - What the change does
   - Why it's needed
   - How to test it
   - Any breaking changes

## Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on the code, not the person
- Help newcomers learn and grow

## Questions?

- Open an issue for bugs or feature requests
- Tag issues with appropriate labels
- Search existing issues before creating new ones

## License

By contributing to GameMath, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for making GameMath better!** 🎉
