# Development session log

This is a repository-evidence summary, not a complete transcript. Dates and commit references come from Git history and available Actions evidence.

## 2026-11-20 — current repository evidence

- **Initial prototype:** commit `c404506` added the offline 1v7 Godot prototype with Survivor/Hunter roles. Source is centered in `scripts/main.gd` with a minimal scene, JSON balance, local profile, bots, objectives, defenses, combat, and procedural UI.
- **Android export setup and fixes:** commits from `68a019e` through `f38331f` added/fixed ARMv7 and ARM64 Android exports, SDK/JDK configuration, debug signing, and Godot type/import issues. This sequence is recorded by Git history; it does not establish every earlier device result.
- **Portrait conversion:** `b4c8dd` converted project/world/UI/export orientation to portrait. GitHub Actions run `44741160271` reported parse/startup and first-frame smoke success.
- **Manual artifact gate:** commit `2d4e759` made pushes validation-only and allowed manual dispatch to export debug ARM APKs as 14-day Actions artifacts, without creating a Release.
- **APK integrity validation:** commit `c6133ec` added ZIP, signature, package/version, SDK metadata, and ABI checks plus SHA-256 sums. Push validation succeeded; manual Actions run `44749704663` passed APK checks and uploaded `NIGHTTERROR-device-test-11`, expiring 2026-12-04.
- **Device issues remain:** user-reported earlier black screen and later ZIP extraction/package parse errors are unresolved. The user handles artifact download; no device success is recorded by these CI runs.

## Current follow-up

The immediate verification gap is to compare the downloaded APKs with the artifact checksums, install the matching ABI on-device, and record exact OS/error/log evidence. Do not treat this entry as evidence that the device test occurred.
