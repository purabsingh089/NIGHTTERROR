# Game architecture

## Runtime composition

`project.godot` selects `scenes/main.tscn` as the entry scene. The scene consists of one `Node2D` with `scripts/main.gd` attached. There are no separate gameplay, actor, AI, HUD, or menu scenes at present.

## Main script responsibilities

`scripts/main.gd` currently contains:

- startup, balance JSON parsing, and local profile load/save;
- match phase, role, player/team, objective, door, defense, timer, and result state;
- human keyboard/touch input and movement;
- bot decisions and Hunter AI;
- movement boundary/doorway checks;
- combat, rescue, objectives, escapes, and result classification;
- procedural rendering of the map, characters, HUD, setup screen, and controls.

This concentration is the current architecture, not a modular design recommendation. Before splitting it, preserve shared state and behavior and add repeatable tests.

## State relationships

`_ready` loads balance/profile and initializes setup. `_begin_match` begins preparation; `_process` advances timers and dispatches role/phase-specific updates; hunt updates resolve AI, combat, objectives, and results. `_reset_match` resets match data and bots; `_end_match` stores result state and persists the profile. `_draw` renders the current state. Input goes through `_input`, `_handle_action_touch`, `_interact`, and `_attack`.

## Data and external systems

`data/balance.json` holds grouped match, Survivor, Hunter, and room/defense tunables. The map geometry and several initial values remain constants in the script. `user://profile.json` is local persistence. There is no event bus, database, backend, networking layer, dependency injection, or external runtime service.

## Changes and risk boundaries

The single script has cross-dependent mutable state. Inspect phase gates, both role branches, bot arrays, end conditions, HUD labels, input hitboxes, reset behavior, balance keys, and profile writes before changing it. See [technical architecture](TECHNICAL_ARCHITECTURE.md), [save format](DATABASE_AND_SAVE_SYSTEM.md), and [testing](TESTING_DOCUMENTATION.md).
