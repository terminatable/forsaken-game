# Development Guide

This guide covers the development setup, workflow, and best practices for the Forsaken game project.

## 📋 Table of Contents
- [Development Environment](#development-environment)
- [Project Architecture](#project-architecture)
- [Code Organization](#code-organization)
- [Development Workflow](#development-workflow)
- [Debugging](#debugging)
- [Performance Profiling](#performance-profiling)
- [Common Tasks](#common-tasks)

## 🛠️ Development Environment

### Required Tools
- **Zig 0.11.0+** - [Download](https://ziglang.org/download/)
- **Git** - Version control
- **VS Code** (recommended) with Zig extension
- **GitHub CLI** (optional) - For issue management

### VS Code Setup
1. Install the Zig Language extension
2. Install the Error Lens extension for inline errors
3. Configure settings:
```json
{
  "zig.path": "/path/to/zig",
  "zig.zls.enable": true,
  "zig.formattingProvider": "zls",
  "editor.formatOnSave": true
}
```

### Environment Variables
```bash
export ZIG_GLOBAL_CACHE_DIR=$HOME/.cache/zig
export FORSAKEN_DEBUG=1  # Enable debug output
export FORSAKEN_ASSETS=/path/to/custom/assets  # Custom asset path
```

## 🏗️ Project Architecture

### ECS Architecture
The game uses Entity-Component-System architecture from Artemis Engine:

```
Entity (ID) → Components (Data) → Systems (Logic)
```

#### Key Systems
- **R6CharacterSystem** - Manages character bodies and animations
- **CombatSystem** - Handles combat mechanics
- **PhysicsSystem** - Physics simulation
- **RenderSystem** - Rendering pipeline
- **InputSystem** - Input handling

### Component Structure
```zig
pub const Transform = struct {
    position: Vec3,
    rotation: Quaternion,
    scale: Vec3,
};

pub const Health = struct {
    current: f32,
    maximum: f32,
    regeneration: f32,
};
```

### System Example
```zig
pub fn movementSystem(world: *World, delta: f32) void {
    var query = world.query(&.{ Transform, Velocity });
    while (query.next()) |entity| {
        var transform = entity.get(Transform);
        const velocity = entity.get(Velocity);
        transform.position = transform.position.add(velocity.scale(delta));
    }
}
```

## 📁 Code Organization

### Directory Structure
```
src/
├── main.zig              # Entry point
├── game.zig              # Game state management
├── systems/              # ECS systems
│   ├── character.zig
│   ├── combat.zig
│   ├── physics.zig
│   └── render.zig
├── components/           # ECS components
│   ├── transform.zig
│   ├── health.zig
│   └── inventory.zig
├── ui/                   # User interface
│   ├── hud.zig
│   ├── menu.zig
│   └── inventory_ui.zig
├── ai/                   # AI systems
│   ├── behavior_tree.zig
│   └── pathfinding.zig
└── utils/               # Utilities
    ├── math.zig
    └── assets.zig
```

### Naming Conventions
- **Files**: snake_case.zig
- **Types**: PascalCase
- **Functions**: camelCase
- **Constants**: SCREAMING_SNAKE_CASE
- **Variables**: snake_case

## 🔄 Development Workflow

### Branch Strategy
```
main
├── develop
│   ├── feature/issue-123-character-system
│   ├── fix/issue-456-combat-bug
│   └── refactor/physics-optimization
└── release/v0.1.0
```

### Typical Development Flow
1. **Pick an Issue**
   ```bash
   gh issue list --label "good first issue"
   gh issue view 123
   ```

2. **Create Branch**
   ```bash
   git checkout develop
   git pull upstream develop
   git checkout -b feature/issue-123-description
   ```

3. **Development Loop**
   ```bash
   # Make changes
   zig build dev  # Run in dev mode
   zig build test # Run tests
   zig fmt src/   # Format code
   ```

4. **Commit Changes**
   ```bash
   git add .
   git commit -m "feat(character): add jump mechanics

   - Implemented double jump
   - Added coyote time
   - Fixed edge cases

   Closes #123"
   ```

5. **Push and PR**
   ```bash
   git push origin feature/issue-123-description
   gh pr create --fill
   ```

## 🐛 Debugging

### Debug Build
```bash
zig build -Doptimize=Debug
```

### Debug Output
```zig
const std = @import("std");
const debug = std.debug;

// Simple debug print
debug.print("Position: {}\n", .{position});

// Conditional debug
if (builtin.mode == .Debug) {
    debug.print("Debug: {s}\n", .{message});
}

// Assert for debug builds
debug.assert(health >= 0);
```

### GDB Debugging
```bash
# Build with debug symbols
zig build -Doptimize=Debug

# Run with GDB
gdb ./zig-out/bin/forsaken-r6-prototype
(gdb) break main
(gdb) run
(gdb) bt  # backtrace
```

### Memory Debugging
```zig
// Use GeneralPurposeAllocator for leak detection
var gpa = std.heap.GeneralPurposeAllocator(.{}){};
defer _ = gpa.deinit();
const allocator = gpa.allocator();
```

## 📊 Performance Profiling

### Built-in Profiling
```zig
const Timer = std.time.Timer;

var timer = try Timer.start();
// Code to profile
const elapsed = timer.read();
debug.print("Elapsed: {} ns\n", .{elapsed});
```

### Benchmarking
```bash
# Run benchmarks
zig build benchmark

# Profile with perf (Linux)
perf record ./zig-out/bin/forsaken-r6-prototype
perf report
```

### Performance Tips
- Use arena allocators for temporary data
- Batch render calls
- Use SOA (Structure of Arrays) for hot data
- Profile before optimizing
- Cache frequently accessed data

## 📝 Common Tasks

### Adding a New System
1. Create system file in `src/systems/`
2. Define system function
3. Register in main game loop
4. Add tests

### Adding a New Component
1. Create component file in `src/components/`
2. Define component struct
3. Register with world
4. Update relevant systems

### Adding a New Feature
1. Create issue on GitHub
2. Design component/system architecture
3. Implement with tests
4. Update documentation
5. Submit PR

### Running Specific Tests
```bash
# Run all tests
zig build test-all

# Run specific test file
zig test src/r6_character.zig

# Run with filter
zig test src/r6_character.zig --test-filter "animation"
```

### Asset Pipeline
```bash
# Process assets
zig build process-assets

# Hot reload assets (during development)
FORSAKEN_HOT_RELOAD=1 zig build run
```

## 🔧 Build Configurations

### Custom Build Options
```bash
# Enable specific features
zig build -Denable-multiplayer=true
zig build -Denable-mod-support=true

# Platform-specific builds
zig build -Dtarget=x86_64-windows
zig build -Dtarget=aarch64-macos
zig build -Dtarget=x86_64-linux-gnu
```

### Cross-Compilation
```bash
# Windows from Linux/macOS
zig build -Dtarget=x86_64-windows-gnu

# Linux from Windows/macOS  
zig build -Dtarget=x86_64-linux-musl

# macOS from Linux/Windows (limited)
zig build -Dtarget=aarch64-macos
```

## 📚 Additional Resources

- [Zig Language Reference](https://ziglang.org/documentation/)
- [Artemis Engine Docs](https://github.com/terminatable/artemis-engine)
- [ECS Architecture Guide](https://github.com/SanderMertens/ecs-faq)
- [Game Programming Patterns](https://gameprogrammingpatterns.com/)

---

*For more information, see the [Contributing Guide](../CONTRIBUTING.md)*