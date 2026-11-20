# Development decisions

This record captures durable decisions supported by repository history or current configuration. It does not invent undocumented alternatives or rationales.

| Date | Decision | Evidence / reason | Consequence |
|---|---|---|---|
| 2026-11-20 | Keep NIGHTTERROR original; use reference archive only for high-level analysis | `GAME PROMPT.MD` requires original code/assets/identity; `reference_analysis.md` documents limits of the cached minified build | Reference archive is not runtime content; do not copy its assets/code |
| 2026-11-20 | Target portrait Android presentation at 540×960 | `project.godot`, `export_presets.cfg`, portrait-layout commit `b4c8cdd` | Coordinates and controls are designed around a fixed portrait canvas; device safe areas remain unverified |
| 2026-11-20 | Keep APK export manual and artifacts unpublished | Workflow history/commit `2d4e759`; `.github/workflows/build-apks.yml` gates exports behind manual dispatch and uploads 14-day artifacts | Push validation remains lightweight; no GitHub Release or external publishing |
| 2026-11-20 | Validate APK integrity/signature/metadata before upload | Workflow commit `c6133ec` and successful run `44749704663` | CI rejects malformed/wrong-ABI test APKs and publishes checksums in its artifact; does not prove device behavior |
| 2026-11-20 | Maintain the current narrow offline prototype as the implementation baseline | Initial prototype commit `c404506`; current source remains a single-scene offline game | Broad features in the master prompt remain proposed until implemented and verified |

No playtest-derived balance decisions are documented. Exact tunables remain in `data/balance.json`; successful headless/CI checks are not gameplay playtests.
