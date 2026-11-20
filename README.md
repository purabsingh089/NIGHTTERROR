# NIGHTTERROR

NIGHTTERROR is an original portrait-oriented Godot 4.3 offline asymmetric horror-survival prototype for Android. Its current playable slice is a local practice match with a Survivor or Hunter role, scripted Survivor bots, two power objectives, a single exit, and simple defenses. It is not online multiplayer or a finished game.

## Open and run

Open this directory in Godot 4.3 and run `scenes/main.tscn` (the project main scene). Keyboard controls are WASD/arrow keys to move, `1`/`2` to choose a role during setup, Enter/E to interact, and Space to attack. Touch controls are also drawn in game; see [UI/UX documentation](docs/UI_UX_DOCUMENTATION.md).

## Build and validation

Android export presets target debug APKs for ARMv7 and ARM64. Pushes to `main` run parsing and headless startup checks only; manually dispatching the Actions workflow also exports, validates, checksums, and uploads 14-day test artifacts. See [build and deployment](docs/BUILD_AND_DEPLOYMENT.md) and [testing](docs/TESTING_DOCUMENTATION.md). A passing headless or APK check does not prove Android rendering or gameplay works on a device.

## Project knowledge

- [Project overview](docs/PROJECT_OVERVIEW.md) — concise source-of-truth index.
- [Project memory](docs/PROJECT_MEMORY.md) — consolidated current context and history.
- [Feature status](docs/FEATURE_STATUS.md) — implemented, partial, proposed, and unverified capabilities.
- [Game design document](docs/GAME_DESIGN_DOCUMENT.md) — separates current slice from intended design.
- [Development roadmap](docs/DEVELOPMENT_ROADMAP.md) and [known issues](docs/KNOWN_ISSUES.md).
- [CLAUDE.md](CLAUDE.md) — contributor and future-agent instructions.

## Source of truth

Runtime implementation is in `scripts/main.gd`; balance is in `data/balance.json`; engine/display configuration is in `project.godot`; the scene root is `scenes/main.tscn`; Android presets and CI live in `export_presets.cfg` and `.github/workflows/build-apks.yml`. The large `GAME PROMPT.MD` is an aspirational design brief, not a description of shipped code. The tracked Haunted Dorm archive is reference material only and is not loaded by the game.
