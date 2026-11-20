# NIGHTTERROR project memory

## Source of truth

This repository is the persistent project record. Read this file, [feature status](FEATURE_STATUS.md), and the newest [session log](SESSION_LOG.md) entry before continuing. Then inspect live source: `scripts/main.gd` for behavior; `data/balance.json` for tunables; `project.godot` and `scenes/main.tscn` for engine/display/entry; `export_presets.cfg` and `.github/workflows/build-apks.yml` for Android builds. Documentation is a map, not a substitute for code.

## What exists

Godot 4.3, GDScript, portrait 540×960, GL Compatibility; one root `Node2D` scene, with most systems in one script. The game draws its simple map, characters, HUD, buttons, and touch joystick procedurally. It is a local practice match with Survivor/Hunter role choice, preparation/hunt/result phases, one fixed room, a doorway, two power objectives, one exit, six Survivor bots, one turret, one shock ward, and a version-1 local JSON profile.

The bot and Hunter behavior are scripted and limited, not production navigation or advanced AI. The profile stores only two local outcome counts. There is no online game, backend, API client, competitive ranking, game audio, separate art package, or repository-resident gameplay test suite.

## Relationships and constraints

- Match phase gates combat/objective/Hunter activity; preparation permits Survivor movement and selected repair/build actions.
- Objectives gate the exit; team escape/elimination and the hunt timer classify results.
- Human Survivor actions interact with objectives, defenses, rescue, door, and Hunter; Hunter role uses attack and sprint actions.
- Bots use fixed map points and the shared movement helper. Navigation/collision behavior is not proven by headless startup.
- Balance values are grouped in `data/balance.json`, while fixed map geometry and initial resource amount remain code constants in `scripts/main.gd`.
- Do not mistake procedural shapes for production art or the tracked reference archive for a runtime dependency.

## Build and verification facts

Push to `main` runs Godot project parse and headless startup/first-frame checks only. Manual workflow dispatch runs those first, then exports ARMv7 and ARM64 debug APKs, validates ZIP/signature/package/SDK/ABI, generates checksums, and uploads a 14-day Actions artifact. No GitHub Release is created. Latest documented successful run is `44749704663`, commit `c6133ec`, artifact `NIGHTTERROR-device-test-11` (expires 2026-12-04). CI validation is not device validation.

The user reported that an earlier installed build showed the Godot splash then a black screen, and later reported an archive extraction data error and Android package parse error. The root cause and current device behavior are unknown. Never claim the issue fixed without on-device evidence.

## Design intent vs implementation

`GAME PROMPT.MD` is a broad aspirational brief. Proposed items include multi-room/data-driven maps, room capacity, beds and multiple currencies, build/upgrade systems, more Hunter abilities, richer AI, progression, settings, Nakama/PostgreSQL networking, and a full test suite. None is evidence of implementation. The tracked `dynamic_game_haunted_dorm.zip` is analysis material, not game content. Its endpoints/assets must not be described as NIGHTTERROR systems or copied into the game.

## History in the available repository

Git history records the initial offline prototype (`c404506`), Android export workflow and fixes, portrait conversion (`b4c8cdd`), manually gated Actions test artifacts (`2d4e759`), and artifact validation additions (`c6133ec`). Run evidence and user/device reports are summarized in [session log](SESSION_LOG.md) and [known issues](KNOWN_ISSUES.md). This is not a transcript of every development conversation; details not committed or present in evidence are unknown.

## Future-session rule

Update the feature matrix and session log when verified implementation changes; update the relevant system note and decision log where needed. Keep each important fact anchored to its source and distinguish current behavior, partial prototype, proposed requirement, and unverified claim.
