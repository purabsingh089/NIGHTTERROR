# Technical architecture

## Runtime stack

- Engine: Godot 4 project features declare `4.3`.
- Language: GDScript.
- Renderer: GL Compatibility, including mobile renderer setting.
- Display: 540×960 portrait viewport with canvas-item stretch.
- Entry scene: `scenes/main.tscn`, a root `Node2D` using `scripts/main.gd`.
- Balance/configuration: JSON at `data/balance.json`.

## Source layout

The tracked project is intentionally small: one gameplay script, one scene, one balance JSON, project settings, two Android export presets, workflow, design prompt, reference archive, and current status/reference notes. There are no third-party game-code dependencies or dependency manifest in the tracked runtime project.

## Runtime data flow

`_ready` parses the balance file and loads the local profile before entering setup. `_process` advances timers, resources and movement and branches behavior by phase and role. Human and bot actions mutate the same script-owned state. `_draw` renders from that state. Match results update the local profile JSON.

## Android configuration

`export_presets.cfg` defines separate debug ARMv7 and ARM64 APK presets under the same application ID/version. See [build and deployment](BUILD_AND_DEPLOYMENT.md) for CI-specific dependencies and validation. A successful export or headless launch is not evidence of Android device rendering.

## Absent architecture

No TileMap/navigation server, reusable actor scenes, resource database, online transport, API client, server, database, authentication, analytics, crash reporting, or audio manager was found in the checked-in implementation. Proposed systems are described separately and should not be treated as present.
