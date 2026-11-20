# Instructions for future Claude sessions

## Read first

1. Read `docs/PROJECT_MEMORY.md`.
2. Read `docs/FEATURE_STATUS.md` and the newest entries in `docs/SESSION_LOG.md`.
3. Read the relevant system note and inspect current source/configuration before relying on documentation.

## Project facts

NIGHTTERROR is currently a Godot 4.3 portrait Android-targeted offline prototype. Gameplay, match state, AI, drawing, input, and profile persistence are concentrated in `scripts/main.gd`. `GAME PROMPT.MD` contains goals and proposed features; it must never be treated as proof of implementation. Multiplayer, network/backend APIs, progression beyond two local counters, dedicated art/audio assets, and gameplay test suites are not implemented in the checked-in project.

## Working rules

- Verify claims against source, configuration, GitHub workflow, and evidence; use `implemented`, `partial`, `proposed`, or `unknown` accurately.
- Before changing a system, trace its callers, state transitions, balance keys, draw/input paths, and save effects in `scripts/main.gd`.
- Preserve the existing prototype and avoid broad refactors or unrelated features.
- Keep tunable values in `data/balance.json` where the existing implementation does so; do not imply every value is data-driven.
- Do not add Haunted Dorm archive assets/code, credentials, signing keys, APKs, caches, or generated exports to Git.
- Keep Android build behavior manual for APK export. Push validation does not publish APKs; manual builds upload short-lived Actions artifacts, not Releases.
- Never claim Android rendering, touch, gameplay, or install success from headless checks alone. The previously reported black screen and package/extraction errors remain unresolved until device-verified.
- Update `docs/FEATURE_STATUS.md`, `docs/SESSION_LOG.md`, and the relevant system doc when implementation changes; update `docs/DECISIONS.md` for meaningful architectural choices.

## Validation

See `docs/TESTING_DOCUMENTATION.md` for what each check proves. The standard CI workflow is `.github/workflows/build-apks.yml`; validate YAML/config and run `git diff --check` for documentation/config changes. Do not manually dispatch APK export unless the user requests a test build. Never force-push or overwrite remote work.

## Documentation map

`docs/PROJECT_OVERVIEW.md` is the index. Detailed implementation topics are split among gameplay, mechanics, architecture, AI, offline, UI, assets, save, networking, build, testing, roadmap, and issue notes. The status matrix is authoritative for feature maturity; `docs/GAME_DESIGN_DOCUMENT.md` describes proposed direction separately from the current build.
