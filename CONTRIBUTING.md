# Contributing to Forsaken Game

🎮 Thank you for your interest in contributing to the Forsaken game project! This document provides guidelines and instructions for contributing.

## 📋 Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [How to Contribute](#how-to-contribute)
- [Development Workflow](#development-workflow)
- [Code Style Guidelines](#code-style-guidelines)
- [Testing](#testing)
- [Documentation](#documentation)
- [Community](#community)

## 📜 Code of Conduct

We are committed to providing a welcoming and inclusive environment. Please:
- Be respectful and considerate
- Welcome newcomers and help them get started
- Focus on constructive criticism
- Respect differing viewpoints and experiences

## 🚀 Getting Started

### Prerequisites
- Zig 0.11.0 or later
- Git
- GitHub account
- Basic understanding of ECS architecture
- Familiarity with game development concepts

### Fork and Clone
1. Fork the repository on GitHub
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/forsaken-game.git
   cd forsaken-game
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/terminatable/forsaken-game.git
   ```

## 🛠️ Development Setup

### Initial Setup
```bash
# Install dependencies
zig build setup

# Build the project
zig build

# Run tests
zig build test-all

# Run the game
zig build run
```

### Development Mode
```bash
# Run with debug output
zig build dev

# Run specific tests
zig build test-r6      # Test R6 character system
zig build test-renderer # Test renderer

# Format code
zig fmt src/
```

## 🤝 How to Contribute

### Reporting Bugs
1. Check [existing issues](https://github.com/terminatable/forsaken-game/issues) first
2. Use the bug report template
3. Provide detailed steps to reproduce
4. Include system information
5. Attach logs if applicable

### Suggesting Features
1. Check the [project roadmap](https://github.com/terminatable/forsaken-game/issues?q=label%3Aroadmap)
2. Use the feature request template
3. Explain the problem your feature solves
4. Provide implementation ideas if possible

### Submitting Code
1. Pick an issue labeled `good first issue` or `help wanted`
2. Comment on the issue to claim it
3. Create a feature branch
4. Make your changes
5. Write/update tests
6. Update documentation
7. Submit a pull request

## 🔄 Development Workflow

### Branch Naming Convention
- `feature/issue-#-description` - New features
- `fix/issue-#-description` - Bug fixes
- `docs/description` - Documentation changes
- `refactor/description` - Code refactoring
- `test/description` - Test additions/changes

### Commit Messages
Follow conventional commits format:
```
type(scope): subject

body (optional)

footer (optional)
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test changes
- `perf`: Performance improvements
- `chore`: Maintenance tasks

Example:
```
feat(combat): add parrying mechanics

Implemented timing-based parry system with visual feedback
and stun mechanics for successful parries.

Closes #14
```

### Pull Request Process
1. Update your fork:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```
2. Create a feature branch:
   ```bash
   git checkout -b feature/issue-123-cool-feature
   ```
3. Make changes and commit
4. Push to your fork:
   ```bash
   git push origin feature/issue-123-cool-feature
   ```
5. Create a pull request using the template
6. Wait for review and address feedback
7. Merge after approval

## 🎨 Code Style Guidelines

### Zig Style
- Use `zig fmt` for formatting
- Follow Zig naming conventions:
  - `snake_case` for variables and functions
  - `PascalCase` for types
  - `SCREAMING_SNAKE_CASE` for constants
- Keep functions focused and small
- Document public APIs
- Use meaningful variable names

### Project Structure
```
forsaken-game/
├── src/
│   ├── main.zig           # Entry point
│   ├── r6_character.zig   # R6 character system
│   ├── combat_system.zig  # Combat mechanics
│   ├── ui/                # UI components
│   ├── ai/                # AI systems
│   └── tests/             # Test files
├── assets/                # Game assets
├── docs/                  # Documentation
└── build.zig             # Build configuration
```

### Best Practices
- Write self-documenting code
- Add comments for complex logic
- Use const where possible
- Handle errors explicitly
- Avoid premature optimization
- Follow DRY (Don't Repeat Yourself)
- Write tests for new features

## 🧪 Testing

### Test Requirements
- All new features must have tests
- Bug fixes should include regression tests
- Maintain > 70% code coverage
- Tests must pass on all platforms

### Running Tests
```bash
# Run all tests
zig build test-all

# Run specific test suite
zig build test-r6
zig build test-renderer
zig build test-combat

# Run with coverage (when available)
zig build test-coverage
```

### Writing Tests
```zig
test "feature description" {
    // Arrange
    const expected = 42;
    
    // Act
    const result = myFunction();
    
    // Assert
    try std.testing.expectEqual(expected, result);
}
```

## 📚 Documentation

### Code Documentation
- Document all public functions
- Use doc comments (`///`) for public APIs
- Include examples in doc comments
- Keep documentation up to date

Example:
```zig
/// Calculates damage based on attacker stats and defender defense
/// 
/// Parameters:
///   - attacker: The attacking character
///   - defender: The defending character
///   - weapon: The weapon being used
/// 
/// Returns: Calculated damage value
/// 
/// Example:
///   const damage = calculateDamage(player, enemy, sword);
pub fn calculateDamage(attacker: Character, defender: Character, weapon: Weapon) f32 {
    // Implementation
}
```

### User Documentation
- Update user guides for new features
- Add screenshots/GIFs for UI changes
- Keep README.md current
- Update changelog

## 🌟 Recognition

### Contributors
All contributors will be:
- Listed in CONTRIBUTORS.md
- Credited in release notes
- Eligible for special Discord roles
- Invited to contributor meetings

### Types of Contributions
We value all contributions:
- Code contributions
- Bug reports
- Feature suggestions
- Documentation improvements
- Testing and QA
- Community support
- Translations

## 💬 Community

### Communication Channels
- GitHub Issues - Bug reports and features
- GitHub Discussions - General discussion
- Discord Server - Real-time chat (coming soon)
- Twitter - Updates and announcements

### Getting Help
- Check documentation first
- Search existing issues
- Ask in GitHub Discussions
- Tag `@terminatable/forsaken-team` for urgent issues

## 🎯 Priority Areas

Current areas where we need help:
1. **R6 Character System** - Animation and physics
2. **Combat Mechanics** - Balancing and feel
3. **Performance** - Optimization for many entities
4. **Testing** - Unit and integration tests
5. **Documentation** - Guides and tutorials
6. **Platform Support** - macOS and Linux testing

## 📋 Checklist for Contributors

Before submitting a PR, ensure:
- [ ] Code follows style guidelines
- [ ] Tests pass locally
- [ ] Documentation is updated
- [ ] Commits follow conventional format
- [ ] PR template is filled out
- [ ] Issue is linked
- [ ] Changes are rebased on latest main

## 🙏 Thank You!

Thank you for contributing to Forsaken! Your efforts help make this project better for everyone. We look forward to your contributions!

---

*Last updated: September 2024*
*Version: 1.0.0*