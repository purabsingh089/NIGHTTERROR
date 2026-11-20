# Known issues and unverified behavior

## Reported Android installation/startup failures

- A user reported that an earlier ARMv7 APK showed the Godot splash, then a black screen. The cause has not been diagnosed and a fix has not been device-verified.
- A later user report said extracting the downloaded artifact ZIP produced a “data error” and Android rejected its ARMv7 APK with “There was a problem while parsing the package.” The exact extractor, exact file/error, Android version/API, and device ABI were not recorded, so the cause remains unknown.
- A subsequent manual build on commit `c6133ec` passed CI ZIP integrity, debug signature, package/version, SDK metadata, and ABI checks. This rules out those specific CI validation failures for that artifact but does not prove the outer artifact transfer/extraction, Android installation, or app startup on-device.

## Gameplay not playtested on device

Door traversal, collision, bot pathing, Hunter combat, objective balance, touch controls, safe areas, full match start/result flow, and profile persistence are not established by the CI headless smoke test. No checked-in gameplay test suite currently exists.

## Known implementation constraints

- Most logic, AI, rendering, input, and persistence are in a single script.
- The map is one fixed layout; movement uses simplified bounds and doorway checks, not general collision/pathfinding.
- AI is basic scripted steering and distance-based behavior.
- UI uses fixed portrait coordinates; safe-area/responsive behavior is unverified.
- The version-1 local profile has minimal validation and no migration/backup/recovery. Hunter-banish outcome is not counted in the two stored win totals.
- No audio, separate game-art assets, online play, backend, API, or gameplay tests are present.

## Evidence handling

Do not mark the Android issue fixed based on a successful export, checksum, signature, parser, or headless first-frame marker. Update this file only when new device or CI evidence narrows or resolves a specific issue.
