# Milestone Status

## Offline prototype — in progress

### Implemented in source

- Godot 4 project scaffold with an original top-down dorm prototype scene.
- Procedurally drawn original rooms, characters, HUD, map objectives, exit, and touch controls; no Haunted Dorm assets or code are used.
- Survivor movement from touch joystick or keyboard, a 15-second preparation phase followed by an active hunt, room entry/exit through an interactable doorway, passive energy generation, door damage and paid repair, paid turret and shock-ward construction, turret and ward attacks, Hunter pursuit/attacks, Hunter sprint ability, player attack with Hunter stun, rescue interaction, and match end/restart.
- Offline 1 Hunter versus 7 Survivors practice match, with six AI Survivors that channel the two power objectives, switch to the remaining objective when needed, flee nearby Hunter pressure, attack the Hunter at close range, seek the exit, and can be rescued by the player after elimination.
- Offline setup allows the player to choose the Survivor or Hunter role with keyboard or touch controls; the selected Hunter can move, sprint, attack nearby Survivors, break the entry barrier, and win through team elimination or timeout.
- Two hallway power objectives must be activated before the escape point allows a Survivor team win; four escapes win for the team, the Hunter wins when all Survivors are eliminated, and the hunt timer awards the Hunter a timeout win.
- Hunter targets the nearest active Survivor, damages and eliminates team members individually, and the HUD displays active, escaped, and eliminated team counts.
- Local version-1 profile at `user://profile.json` records Survivor escapes and Hunter wins. It is local-only and does not grant online rank/results.
- Match preparation duration, hunt duration, and gameplay balance values stored in `data/balance.json`.
- Separate export presets target `armeabi-v7a` and `arm64-v8a` APK paths.

### Verification

- Offline team-mode source checks verify seven total Survivors, six bots, proximity-gated objective channeling, damage interruption, bot flee behavior, nearest-active-target selection, individual elimination, bot defense attacks, rescue state reset, two player defenses, Hunter sprint and stun state, hunt timeout result, combat target/health HUD, result detail display, four-escape victory, full-team elimination, and restart state reset; balance JSON validation, simulation checks, and `git diff --check` passed.
- Offline role checks verify the setup phase exists, both role constants are wired, keyboard (1/2) and touch role selection work only during setup, the touch start hitbox matches the drawn Start button, Hunter movement is gated while stunned, `_hunter_attack_nearby` exists with the stun gate, `_begin_match` transitions SETUP to PREPARATION with fresh timers, `_reset_match` clears `primary_objective_time`/`primary_attack_time`, HUD role/health/target labels adapt to the selected role, restart returns to setup, and no unsupported draw calls or direct Hunter position writes remain; 12/12 wiring checks and 13/13 gameplay invariants pass.
- GitHub Actions run 44712936748 successfully parsed the project, exported and signed both ARMv7 and ARM64 APKs, and verified both files. The user installed the ARMv7 APK; it showed the Godot splash and then a black screen.
- The project viewport and both Android export presets use portrait orientation at 540×960. World geometry, room traversal, objectives, exit, player/Hunter/bot spawns, defenses, setup choices, HUD, result overlay, joystick, and touch controls have been converted to portrait coordinates; setup/action controls share drawing and touch-hitbox constants.
- Static portrait checks, six-bot doorway-to-objective-to-exit navigation, Hunter/exit separation, HUD/control bounds and spacing, `git diff --check`, `data/balance.json` parsing, gdtoolkit parsing of `main.gd`, and workflow YAML parsing pass. `gdlint` reports only long-line and `_interact` return-count style rules, also present in the committed baseline.
- GitHub Actions run 44741160271 passed on portrait commit `b4c8cdd6fca0266c14c1648d33a39916a1afff12`: Godot 4.3 parsed the project and the headless startup smoke test emitted `NIGHTTERROR_READY` and `NIGHTTERROR_FIRST_FRAME`.
- The current `.github/workflows/build-apks.yml` keeps pushes validation-only; manual dispatch validates first, then builds debug ARMv7/ARM64 APKs, checks ZIP integrity/signature/package/version/SDK/ABI, writes SHA-256 checksums, and uploads a 14-day Actions artifact. No GitHub Release or external publishing step exists.
- GitHub Actions run `44749704663` on commit `c6133ec` passed headless parse/startup and both APK validation checks, uploading `NIGHTTERROR-device-test-11` (expires 2026-12-04). This validates CI artifacts only; it does not verify download integrity on the device, installation, Android rendering, safe areas, touch alignment, or match start.
- The user later reported an extraction “data error” and Android’s “There was a problem while parsing the package” for ARMv7. Exact extractor/file, device API/ABI, and PackageManager logs are unavailable, so the cause and resolution are unverified. The earlier black-screen report is also unresolved.

### Known limitations

- This remains a prototype, not the full MVP: no map selection or online mode. The AI team, two defense types, rescue flow, Hunter sprint, and the offline Hunter role are scripted offline practice systems, not networked multiplayer.
- Gameplay, UI drawing, and input remain concentrated in `scripts/main.gd`.
- Room entry/exit is gated at the room boundary by the doorway opening and door state, but collision, Hunter pathing/combat, objective interactions, and balance have not been gameplay-playtested. Headless startup validation has run; no device gameplay validation is recorded. Hunter door and Survivor attacks use their separate configured cooldowns.
- Match phases are `SETUP`, `PREPARATION`, `HUNT`, and `RESULT`: setup collects the role choice, the Survivor can move and prepare defenses during the 15-second countdown, while objectives, combat, turret fire, and Hunter updates are hunt-gated. Phase/timer resets and result classification have only been reviewed statically.
- Room-boundary crossing is checked at the actual crossing point through the doorway opening; collision and movement have not been runtime-tested.
- Export preset compatibility with a specific Godot release/export template is unverified.

### Next

1. Verify the downloaded `NIGHTTERROR-device-test-11` APK against the artifact's `SHA256SUMS.txt`, then install the ABI-matching APK on the affected device.
2. Check portrait rendering, safe areas, touch alignment, setup/role selection, and match start; do not claim the black-screen or package-parse issue is fixed until this succeeds.
3. If extraction or launch still fails, capture the exact archive/APK error, Android version and supported ABI, plus Android runtime/PackageManager logs.
4. Add broader offline match systems only after the current slice is runtime-validated.
