# NIGHTTERROR game design

## Pitch

An original portrait top-down asymmetric horror-survival game: a Hunter pressures a Survivor team that must prepare, activate infrastructure, cooperate, and escape. The current repository is an offline prototype of this premise. The broader game below is **proposed**, not implemented.

## Audience and platform

The design brief targets Android and mobile touch play. No audience research or user testing is recorded. The current Godot project uses a 540×960 portrait canvas and supports keyboard/mouse input for development as well as touch input.

## Pillars proposed by the design brief

1. Asymmetric roles with different goals and pressure.
2. Strategic preparation and resource investment.
3. Objectives that make Survivors leave safety and coordinate.
4. An original dark, readable visual identity.
5. Offline play remains available; any future competitive online outcome is server-authoritative.

These pillars summarize `GAME PROMPT.MD`; they are not all realized by the prototype.

## Current prototype loop

Choose Survivor or Hunter; enter preparation; transition automatically into a timed hunt. The Survivor side channels two power objectives and reaches the exit, while the Hunter pursues, attacks, and can break the doorway. Four escapes win the Survivor team; eliminating the team or surviving the timer wins the Hunter. The exact implementation and balance are in `scripts/main.gd` and `data/balance.json`; see [gameplay systems](GAMEPLAY_SYSTEMS.md) and [mechanics](GAME_MECHANICS.md).

## Intended broader game — proposed

`GAME PROMPT.MD` proposes multi-room maps, room occupancy, beds and resource production, several resource types, configurable constructions/upgrades, more objectives, richer Hunter abilities, stateful AI, progression, settings, and online matches backed by Nakama/PostgreSQL. These are goals only; see [feature status](FEATURE_STATUS.md) for the as-built matrix. Do not infer detailed rules or values beyond those explicitly present in the prompt.

## Visual and audio direction

The brief requests original dark vector-style 2D art, readable role silhouettes, atmospheric effects, and original sound/music. Current visuals are simple procedural Godot draw calls with the fallback font. No game audio playback or separate original asset set is present; see [asset documentation](ASSET_DOCUMENTATION.md).

## Design decisions

The project is currently a single-scene, script-concentrated offline slice with a portrait canvas, chosen for incremental device-targeted prototyping. The Android export workflow is validation-gated and manual for APK artifacts. See [decisions](DECISIONS.md) for evidence and limits.
