# Feature status

This matrix describes the checked-in implementation, not the ambition of `GAME PROMPT.MD`. **Implemented** means present in source; it does not imply device-tested or production-ready. **Partial** means a narrow scripted prototype exists. **Proposed** means the design brief requests it but source does not implement it. **Unknown/unverified** means evidence is insufficient.

| Area | Status | Verified scope and source |
|---|---|---|
| Godot project entry and portrait canvas | Implemented | Godot 4.3 project config and minimal `Node2D` scene; `project.godot`, `scenes/main.tscn` |
| Setup and match phases | Implemented | Role setup, preparation, hunt, result; `scripts/main.gd`, `data/balance.json` |
| Survivor player role | Implemented | Movement, objective activation, attack/stun, rescue, escape; `scripts/main.gd` |
| Hunter player role | Implemented | Movement, sprint, nearby attack, doorway damage; `scripts/main.gd` |
| Local team match | Partial | One player role versus scripted 1v7-side setup; six Survivor bots; fixed map; `scripts/main.gd` |
| Survivor bots | Partial | Objective channel/switch, flee, close attack, exit-seeking, elimination/rescue state; no robust navigation or strategic state machine; `scripts/main.gd` |
| Hunter AI | Partial | In Survivor role, nearest active target pursuit, speed boost and attack/door logic; no limited-information model or difficulty system; `scripts/main.gd` |
| Objectives and escape | Implemented | Two fixed power nodes gate one exit; four team escapes win; `scripts/main.gd`, `data/balance.json` |
| Economy and defenses | Partial | Energy generation, fixed one-of-each turret/ward and paid repair; no placement, upgrades, multi-currency, or broad build system; `scripts/main.gd`, `data/balance.json` |
| Door and traversal | Partial | Fixed room boundary and doorway check with health/open timer; collision/pathfinding not verified; `scripts/main.gd` |
| Procedural HUD and touch controls | Partial | Fixed portrait drawing, joystick, action buttons; safe areas/responsive layout/device alignment unverified; `scripts/main.gd` |
| Local profile | Partial | Version-1 JSON with Survivor escapes and Hunter wins; no migration/backup/settings/unlocks; `scripts/main.gd` |
| Separate NIGHTTERROR art and audio | Not implemented | Visuals are drawn in code; no audio playback/assets in project tree; `scripts/main.gd` |
| Online multiplayer/backend/API | Not implemented | No client, server, authentication, endpoint integration, database, or network state in game source |
| Progression, ranked play, matchmaking | Proposed | Present in `GAME PROMPT.MD`, absent from implementation |
| Android test exports | Implemented in CI | ARMv7/ARM64 debug exports, validation and 14-day artifacts on manual dispatch; no Release; `export_presets.cfg`, workflow |
| Automated gameplay test suite | Not implemented | CI checks parsing/startup and APK metadata/integrity; no committed gameplay test directory |
| Android device gameplay | Unknown/unverified | Prior black-screen and package/extraction reports; no successful device validation recorded |

## Evidence conventions

For exact match timings, damage, costs, and intervals, read `data/balance.json` rather than copying numbers into this tracker. Current workflow behavior is in `.github/workflows/build-apks.yml`. The latest successful APK validation is run `44749704663` (commit `c6133ec`); it verifies artifacts, not device behavior.
