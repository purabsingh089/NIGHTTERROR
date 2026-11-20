# Testing and verification

## Repeatable repository workflow checks

`.github/workflows/build-apks.yml` runs on pushes to `main` and manual dispatch:

1. Godot 4.3 editor/headless project parse; checks logs for script/load errors.
2. Headless startup for a short interval; requires exact `NIGHTTERROR_READY` and `NIGHTTERROR_FIRST_FRAME` markers and rejects startup error markers.
3. Manual dispatch only: export ARMv7 and ARM64 debug APKs, check ZIP integrity, verify signatures with `apksigner`, inspect package/version/SDK/ABI using Android build tools, and produce checksums before upload.

Latest documented results: push validation and manual APK validation succeeded on commit `c6133ec`; manual run `44749704663` created `NIGHTTERROR-device-test-11`. See `BUILD_AND_DEPLOYMENT.md`.

## Non-repeatable historical checks

`milestone_status.md` records static source checks and simulations performed during development. No corresponding checked-in gameplay test harness was found; treat these as historical reported checks, not a runnable automated suite.

## What is not covered

CI does not run a full match, validate bots/combat/objective results, check profile persistence, test airplane-mode behavior, measure performance, or test Android touch/display/safe areas. APK metadata and a passing first-frame smoke marker do not prove the game works on a physical device.

## Device acceptance still needed

On the affected Android device, install the matching ABI, verify package installation, portrait rendering, safe areas, touch alignment, setup role selection, match start, basic movement/interactions, and capture system logs if startup fails. The previous black-screen and parse/extraction reports remain unresolved. Do not mark these checks complete until directly observed and recorded with device/OS/build details.
