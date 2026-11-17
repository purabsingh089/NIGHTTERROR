# Haunted Dorm Reference Analysis

## Scope and evidence

Inspected `dynamic_game_haunted_dorm.zip` from the repository on 2026-11-17. The archive contains a LayaAir web-game build, JSON configuration/data, UI prefabs, localization, and a minified JavaScript bundle. The findings below describe evidence in that cached build; they are not a claim of complete source-code understanding or runtime testing.

Evidence labels:

- **VERIFIED**: directly visible in an inspected file or bundle symbol.
- **STRONGLY INDICATED**: supported by multiple related data/assets or localization and code symbols.
- **UNKNOWN**: cannot be established from the available files alone.

## Startup and runtime

- **VERIFIED** — `index.html` loads `minigame.js`, then `index.js`. `index.js` sets `window.screenOrientation="portrait"`, loads the minified LayaAir core, animation, and UI libraries, and then `js/bundle.js`.
- **VERIFIED** — the HTML also includes a Laya orientation metadata value of `landscape`, which conflicts with the runtime's portrait setting. Which setting the host ultimately honors is **UNKNOWN** without running the game in its host environment.
- **VERIFIED** — `gameAssets/asset/game.js` is only a short asset-package log statement; the gameplay implementation is in `js/bundle.js`.
- **VERIFIED** — the main gameplay bundle is minified. Its symbols aid navigation, but minification and absent original project/source files limit confidence in full control-flow interpretation.

## Maps and movement

- **VERIFIED** — `gameAssets/asset/data/mapsData.json` contains `map0` through `map9`. Grid dimensions are: maps 0, 4, and 8: 43×37; maps 1–3, 5, and 6: 43×36; map 7: 30×30; map 9: 50×50.
- **VERIFIED** — the bundle includes `MapConversion`, `SelectMap`, and `IsWalkable` symbols associated with map parsing, selection, and walkability checks.
- **STRONGLY INDICATED** — tile strings encode floor/building information and rotations; this is a reference for understanding the data format, not a NIGHTTERROR map specification.
- **UNKNOWN** — the intended selection/unlock sequence for every map and the exact navigation behavior require deeper code tracing or runtime observation.

## Match loop, rooms, and economy

- **VERIFIED** — English localization/tutorial text tells players to enter an empty room before the countdown, get into bed, build/upgrade turrets, upgrade room doors, and repair a door under attack. It also warns about entering rooms after their lights go out.
- **VERIFIED** — the bundle contains `StartTimer` and `GoToBed` symbols, supporting a preparation/countdown stage and a bed-entry flow.
- **STRONGLY INDICATED** — bed upgrades support income generation; door tiers have HP values; turret entries have attack/range-related progression; mines and game consoles have separate resource/output data. These are supported by equipment/build data and localized descriptions.
- **VERIFIED** — equipment data contains 90 entries across weapons, armor/helmets, shoes, books, and hammers. This equipment data is distinct from the building progression described in localization.
- **UNKNOWN** — exact formulas, tick timing, stacking rules, costs in every mode, and whether every listed item is available in all match types are not established by the data alone.

## Hunter, AI, modes, and outcomes

- **VERIFIED** — bundle symbols include `TrollAttack`, `Chase`, `RandomAILevel`, `FindRoom`, `GetAiBuild`, and `GoldCoinDetection`, indicating Hunter attack/chase logic and local AI/player economy decisions.
- **VERIFIED** — bundle symbols include `GameOver`; mode-specific game-over handling is present in the inspected code path.
- **VERIFIED** — the bundle's mode enum labels are Normal, Troll (Dream Hunter), Puppet (Ghosts and Angels), Plot (Story), Couple, and HoneyBadgerRun.
- **UNKNOWN** — the complete rules, unlocks, balance, player counts, elimination/ghost behavior, and victory conditions for each mode have not been established by asset labels or symbol names alone.
- **UNKNOWN** — there is no runtime test in this analysis proving multiplayer connectivity or that the listed endpoints are active or safe to use.

## UI, network, and other systems

- **VERIFIED** — prefab files include `StartGame.json`, `BattleUI.json`, `buildMenu.json`, and `GameOverUI.json`, corroborating start, in-match, build, and result UI surfaces.
- **VERIFIED** — `netConfig.json` lists four WebSocket endpoint strings. Their presence does not establish a working multiplayer client or service; no server requests were made.
- **STRONGLY INDICATED** — localization and prefab labels expose repair, shield, traps, turret modifiers, and other support/defense systems. Labels alone do not prove each system's exact runtime behavior.
- **UNKNOWN** — detailed audio events, mobile touch layout, monetization, server protocol, and full progression flow were not exhaustively observed at runtime.

## NIGHTTERROR design implications

Use only the high-level design pattern supported by the evidence: early location choice, room/door defense, resource investment, and pressure from a pursuing Hunter. NIGHTTERROR should use original maps, names, art, text, code, balance, and UI. Keep objectives and resource collection outside rooms central so remaining in one room is not always optimal. Treat reference-game numbers and labels as evidence to investigate, not as values or feature requirements to copy.

## Repository audit snapshot

At the time of inspection, the repository root contains only `GAME PROMPT.MD` and `dynamic_game_haunted_dorm.zip`. No Godot project file, game source tree, dependency manifest, build configuration, or tests are present. Therefore there is no existing implementation to preserve or test; Phase 0 must establish and verify the project foundation before later phases can be claimed complete.
