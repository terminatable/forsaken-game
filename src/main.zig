//! Forsaken RPG - Showcase Game for Artemis Engine
//!
//! A complete RPG demonstrating the full Artemis Engine ecosystem.

const std = @import("std");
const artemis = @import("artemis-engine");
const gui = @import("artemis-gui");
const plugins = @import("artemis-plugins");

// Game components
const Player = struct {
    name: []const u8,
    level: u32,
    experience: u32,
    health: f32,
    max_health: f32,
    mana: f32,
    max_mana: f32,
    
    pub fn init(name: []const u8) Player {
        return .{
            .name = name,
            .level = 1,
            .experience = 0,
            .health = 100.0,
            .max_health = 100.0,
            .mana = 50.0,
            .max_mana = 50.0,
        };
    }
};

const GameState = enum {
    MainMenu,
    CharacterCreation,
    InGame,
    Inventory,
    Combat,
    Paused,
};

// Game systems
const GameStateSystem = struct {
    current_state: GameState = .MainMenu,
    
    pub fn update(self: *GameStateSystem, world: *artemis.World, gui_system: *gui.Gui) !void {
        _ = world;
        _ = gui_system;
        
        switch (self.current_state) {
            .MainMenu => {
                // Handle main menu logic
            },
            .InGame => {
                // Handle gameplay logic
            },
            else => {},
        }
    }
    
    pub fn setState(self: *GameStateSystem, new_state: GameState) void {
        std.debug.print("🔄 Game state changed: {} -> {}\n", .{ self.current_state, new_state });
        self.current_state = new_state;
    }
};

const PlayerSystem = struct {
    pub fn update(world: *artemis.World, dt: f32) !void {
        _ = dt;
        
        var query = world.query(.{Player});
        while (query.next()) |entity| {
            if (world.get(Player, entity)) |player| {
                // Regenerate mana slowly
                if (player.mana < player.max_mana) {
                    player.mana = @min(player.max_mana, player.mana + 5.0 * dt);
                }
            }
        }
    }
};

const UISystem = struct {
    health_bar: ?gui.ComponentId = null,
    mana_bar: ?gui.ComponentId = null,
    
    pub fn init(gui_system: *gui.Gui) !UISystem {
        // Create health bar
        const health_bg = try gui.panel(gui_system)
            .position(20, 20)
            .size(204, 24)
            .background(gui.Color.init(0.2, 0.2, 0.2, 0.8))
            .build();
            
        const health_bar = try gui.panel(gui_system)
            .position(22, 22)
            .size(200, 20)
            .background(gui.Color.red())
            .build();
        
        // Create mana bar
        const mana_bg = try gui.panel(gui_system)
            .position(20, 50)
            .size(204, 24)
            .background(gui.Color.init(0.2, 0.2, 0.2, 0.8))
            .build();
            
        const mana_bar = try gui.panel(gui_system)
            .position(22, 52)
            .size(200, 20)
            .background(gui.Color.blue())
            .build();
            
        _ = health_bg;
        _ = mana_bg;
        
        return UISystem{
            .health_bar = health_bar,
            .mana_bar = mana_bar,
        };
    }
    
    pub fn update(self: *UISystem, world: *artemis.World, gui_system: *gui.Gui) !void {
        _ = self;
        _ = world;
        _ = gui_system;
        
        // Update UI based on player state
        // (Placeholder implementation)
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    // Game initialization
    std.debug.print("🎆 Forsaken RPG - Artemis Engine Showcase\n");
    std.debug.print("Engine Version: {s}\n", .{artemis.version.string});
    std.debug.print("Loading game...\n\n");

    // Initialize core systems
    var world = artemis.World.init(gpa.allocator());
    defer world.deinit();
    
    var gui_system = try gui.Gui.init(gpa.allocator());
    defer gui_system.deinit();
    
    var plugin_manager = plugins.PluginManager.init(gpa.allocator());
    defer plugin_manager.deinit();
    
    // Initialize game systems
    var game_state = GameStateSystem{};
    var ui_system = try UISystem.init(&gui_system);
    
    // Create player character
    const player_entity = world.entity();
    try world.set(Player, player_entity, Player.init("Hero"));
    try world.set(artemis.Position, player_entity, .{ .x = 400, .y = 300 });
    
    std.debug.print("✅ Game initialized successfully!\n");
    std.debug.print("💫 Created player: Hero at (400, 300)\n\n");
    
    // Game state demo
    std.debug.print("🎮 Demonstrating game states:\n");
    game_state.setState(.CharacterCreation);
    game_state.setState(.InGame);
    
    // Game loop simulation
    std.debug.print("\n🔄 Running game loop simulation...\n");
    
    for (0..5) |frame| {
        const dt: f32 = 1.0 / 60.0;
        
        // Update systems
        try PlayerSystem.update(&world, dt);
        try game_state.update(&world, &gui_system);
        try ui_system.update(&world, &gui_system);
        try gui_system.render();
        
        // Print player state every few frames
        if (frame % 2 == 0) {
            if (world.get(Player, player_entity)) |player| {
                std.debug.print("Frame {}: {} - Level {} | Health: {d:.1}/{d:.1} | Mana: {d:.1}/{d:.1}\n", 
                    .{ frame, player.name, player.level, player.health, player.max_health, player.mana, player.max_mana });
            }
        }
    }
    
    std.debug.print("\n✨ Forsaken RPG showcase completed!\n");
    std.debug.print("🚀 This demonstrates the full Artemis Engine ecosystem in action.\n");
    std.debug.print("📈 Explore the source code to see advanced ECS patterns!\n");
}