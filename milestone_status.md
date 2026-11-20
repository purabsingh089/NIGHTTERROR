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
- Godot parsing, runtime gameplay, save/load on device, APK export, and installation have **not** been tested. This Termux environment has no Godot executable, Java, Android SDK, Gradle, or ADB, and the available Termux package index did not offer Godot.
- Do not treat the export presets as proof that APKs have been built. A supported Godot 4 + Android export-template + JDK/Android SDK host is required.

### Known limitations

- This remains a prototype, not the full MVP: no map selection or online mode. The AI team, two defense types, rescue flow, Hunter sprint, and the offline Hunter role are scripted offline practice systems, not networked multiplayer.
- Gameplay, UI drawing, and input remain concentrated in `scripts/main.gd`.
- Room entry/exit is gated at the room boundary by the doorway opening and door state, but collision, Hunter pathing/combat, objective interactions, and balance have not been playtested; no runtime validation has been possible. Hunter door and Survivor attacks use their separate configured cooldowns.
- Match phases are `SETUP`, `PREPARATION`, `HUNT`, and `RESULT`: setup collects the role choice, the Survivor can move and prepare defenses during the 15-second countdown, while objectives, combat, turret fire, and Hunter updates are hunt-gated. Phase/timer resets and result classification have only been reviewed statically.
- Room-boundary crossing is checked at the actual crossing point through the doorway opening; collision and movement have not been runtime-tested.
- Export preset compatibility with a specific Godot release/export template is unverified.

### Next

1. Open/import in Godot 4; fix parser issues and test the objective, doorway, match, and save flows.
2. Export and install separate ARMv7 and ARM64 APKs on matching devices/emulators.
3. Add broader offline match systems only after this slice is validated.
