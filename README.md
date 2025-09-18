# 🏰 Forsaken Game

[![CI/CD](https://github.com/terminatable/forsaken-game/actions/workflows/ci.yml/badge.svg)](https://github.com/terminatable/forsaken-game/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Zig Version](https://img.shields.io/badge/zig-0.11.0-orange.svg)](https://ziglang.org/)
[![Issues](https://img.shields.io/github/issues/terminatable/forsaken-game)](https://github.com/terminatable/forsaken-game/issues)

> A Rouge Lineage-inspired RPG with R6-style characters built on Artemis Engine, featuring procedural animations and physics-based combat.

## 🎮 Features

### Core Systems
- **R6 Character System** - Six-part character bodies with procedural animations
- **Physics-Based Combat** - Realistic combat with physics interactions
- **Character Customization** - Deep customization options for appearance and abilities
- **Procedural Animations** - Dynamic animation system that adapts to gameplay

### Planned Features
- **Magic System** - Diverse spells and abilities
- **Skill Progression** - Deep character development and specialization
- **World Exploration** - Large, immersive game world
- **Multiplayer Support** - Online cooperative and competitive gameplay

## 🚀 Quick Start

### Prerequisites
- [Zig 0.11.0+](https://ziglang.org/download/)
- Git
- OpenGL 3.3+ compatible graphics card

### Installation

1. Clone the repository:
```bash
git clone https://github.com/terminatable/forsaken-game.git
cd forsaken-game
```

2. Set up asset directories:
```bash
zig build setup
```

3. Build and run:
```bash
zig build run
```

### Development Mode

For development with hot reloading and debug output:
```bash
zig build dev
```

## 🛠️ Building

### Build Options

```bash
# Debug build (default)
zig build

# Release build (optimized)
zig build -Doptimize=ReleaseFast

# Release with safety checks
zig build -Doptimize=ReleaseSafe

# Minimal size build
zig build -Doptimize=ReleaseSmall
```

### Platform-Specific Builds

The build system automatically detects and configures for your platform:
- **Windows** - DirectX/OpenGL rendering
- **macOS** - Metal/OpenGL rendering  
- **Linux** - Vulkan/OpenGL rendering

## 🧪 Testing

Run all tests:
```bash
zig build test-all
```

Run specific test suites:
```bash
zig build test          # Main tests
zig build test-r6       # R6 character system tests
zig build test-renderer # Renderer tests
```

Run benchmarks:
```bash
zig build benchmark
```

## 📁 Project Structure

```
forsaken-game/
├── .github/           # GitHub Actions and templates
├── assets/            # Game assets (models, textures, audio)
├── docs/              # Documentation
├── src/               # Source code
│   ├── main.zig       # Entry point
│   ├── r6_character.zig
│   ├── r6_renderer.zig
│   ├── combat_system.zig
│   ├── ai/            # AI systems
│   ├── ui/            # User interface
│   └── tests/         # Test files
├── build.zig          # Build configuration
├── build.zig.zon      # Package dependencies
└── README.md          # This file
```

## 🎯 Development Roadmap

### Current Sprint (v0.1.0 - Core Prototype)
- [x] Project setup and CI/CD
- [ ] R6 character controller (#5)
- [ ] Animation blending system (#6)
- [ ] Basic melee combat (#8)
- [ ] Terrain generation (#10)

### Upcoming Milestones
- **v0.2.0** - Combat Update
- **v0.3.0** - Progression System
- **v0.4.0** - Polish Pass
- **v0.5.0** - Platform Release
- **v1.0.0** - Multiplayer Alpha

See our [Issues](https://github.com/terminatable/forsaken-game/issues) for detailed task tracking.

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Good First Issues
Check out issues labeled [`good first issue`](https://github.com/terminatable/forsaken-game/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) to get started.

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests
5. Submit a pull request

## 📊 Project Status

| Component | Status | Progress |
|-----------|--------|----------|
| Core Engine | 🟡 In Progress | 60% |
| Character System | 🟡 In Progress | 40% |
| Combat System | 🔴 Planning | 10% |
| World Generation | 🔴 Planning | 5% |
| UI System | 🔴 Planning | 0% |
| Multiplayer | 🔴 Not Started | 0% |

## 🎨 Art Style

Forsaken features a stylized, low-poly aesthetic inspired by classic RPGs with modern lighting and effects. The R6 character style provides a good balance between performance and visual appeal.

## 🔧 Configuration

### Graphics Settings
Edit `config.json` (created on first run):
```json
{
  "graphics": {
    "resolution": [1920, 1080],
    "fullscreen": false,
    "vsync": true,
    "antialiasing": 4,
    "shadows": "medium",
    "view_distance": 100
  }
}
```

### Controls
Default keyboard controls:
- **WASD** - Movement
- **Space** - Jump
- **Shift** - Sprint
- **LMB** - Light Attack
- **RMB** - Heavy Attack
- **Q** - Block
- **E** - Interact
- **Tab** - Inventory
- **Esc** - Menu

## 🐛 Known Issues

- Animation blending not yet implemented (#6)
- No macOS Metal renderer yet
- Performance drops with 50+ characters on screen

See [Issues](https://github.com/terminatable/forsaken-game/issues) for full list.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Artemis Engine Team** - For the powerful ECS framework
- **Rouge Lineage** - For gameplay inspiration
- **Zig Community** - For the amazing programming language
- All contributors and testers

## 📞 Contact & Support

- **Issues**: [GitHub Issues](https://github.com/terminatable/forsaken-game/issues)
- **Discussions**: [GitHub Discussions](https://github.com/terminatable/forsaken-game/discussions)
- **Organization**: [@terminatable](https://github.com/terminatable)

## 🌟 Star History

[![Star History Chart](https://api.star-history.com/svg?repos=terminatable/forsaken-game&type=Date)](https://star-history.com/#terminatable/forsaken-game&Date)

---

<p align="center">
  Made with ❤️ by the Terminatable team
</p>