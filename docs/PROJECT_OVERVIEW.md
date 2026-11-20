# Project overview

## Identity and current scope

NIGHTTERROR is an original top-down asymmetric horror-survival strategy game for Android, intended to contrast a Hunter with a team of Survivors. The actual repository currently implements a small offline practice prototype, not the full design in `GAME PROMPT.MD`. The current game is portrait-oriented, built with Godot 4.3 and GDScript, and uses procedural drawing.

**Current source of truth:** [feature status](FEATURE_STATUS.md), [game architecture](GAME_ARCHITECTURE.md), and `scripts/main.gd`. The design brief is aspirational and is not an implementation inventory.

## Current playable loop

The player selects Survivor or Hunter in setup. A match proceeds through preparation, then a timed hunt. Survivors work on two hallway power objectives before they can escape; the Hunter attacks Survivors and the entry barrier. The local team includes six scripted Survivor bots. A narrow energy economy supports one turret, one shock ward, repairs, and rescues. Detailed behavior and balance are documented in [gameplay systems](GAMEPLAY_SYSTEMS.md) and [mechanics](GAME_MECHANICS.md), with actual tunables in `data/balance.json`.

## Technical shape

One `Node2D` scene attaches `scripts/main.gd`, which currently owns startup, match state, movement, bots, combat, touch/keyboard input, drawing, results, and profile persistence. The fixed portrait map and UI are drawn in script. There is no separate server, online mode, or runtime content pipeline. See [technical architecture](TECHNICAL_ARCHITECTURE.md).

## Evidence boundary

- **Implemented in source:** offline role selection and practice match systems listed in [feature status](FEATURE_STATUS.md).
- **CI-verified:** Godot headless parse/startup and the APK checks described in [testing](TESTING_DOCUMENTATION.md); latest successful manual APK validation is run `44749704663` on commit `c6133ec`.
- **Device-unverified:** Android launch/rendering, safe areas, input alignment, match play, and the cause of prior package/extraction errors. A prior user report described a black screen after the Godot splash. See [known issues](KNOWN_ISSUES.md).
- **Proposed:** online multiplayer, richer room/economy/AI/progression systems, full maps, original production assets, and expanded UX in `GAME PROMPT.MD`.

## Repository map

| Path | Responsibility |
|---|---|
| `project.godot` | Godot version feature, main scene, portrait viewport, renderer |
| `scenes/main.tscn` | Minimal `Node2D` entry scene |
| `scripts/main.gd` | Current game logic, AI, input, UI drawing and local profile |
| `data/balance.json` | Match, Survivor, Hunter, room/defense tunables |
| `export_presets.cfg` | ARMv7 and ARM64 Android debug presets |
| `.github/workflows/build-apks.yml` | Push validation and manually gated APK test artifacts |
| `GAME PROMPT.MD` | Aspirational requirements and design brief, not current status |
| `dynamic_game_haunted_dorm.zip` | Tracked reference archive; not used by the game |

## Further documentation

Start at the root [README](../README.md). Detailed notes: [game design](GAME_DESIGN_DOCUMENT.md), [gameplay](GAMEPLAY_SYSTEMS.md), [mechanics](GAME_MECHANICS.md), [AI](GAME_AI_SYSTEMS.md), [offline](OFFLINE_SYSTEMS.md), [UI](UI_UX_DOCUMENTATION.md), [assets](ASSET_DOCUMENTATION.md), [save data](DATABASE_AND_SAVE_SYSTEM.md), [networking](API_AND_NETWORKING.md), [multiplayer](MULTIPLAYER_ARCHITECTURE.md), [build](BUILD_AND_DEPLOYMENT.md), [testing](TESTING_DOCUMENTATION.md), [roadmap](DEVELOPMENT_ROADMAP.md), and [decisions](DECISIONS.md).
