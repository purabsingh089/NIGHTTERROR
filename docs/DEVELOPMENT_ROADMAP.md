# Development roadmap

This roadmap separates implemented prototype scope from aspirational goals; it does not claim estimates or commitments.

## Immediate validation gap

- Resolve the reported APK extraction/package parse error with exact error details and verify the newly checksummed artifact on device.
- Verify Android portrait rendering, safe areas, touch alignment, setup, and match start. Capture Android logs if failure persists.
- After device startup, playtest doorway movement, bot navigation, objectives, combat, rescue, results, and local profile behavior; record reproducible defects.

## Prototype completion

- Add a repeatable gameplay test harness for state transitions, objective/escape/elimination outcomes, bot decisions, and profile load/save.
- Improve collision, navigation, match balance, and UI only in response to observed defects or agreed requirements.
- Keep workflow validation and device validation as separate acceptance gates.

## Broader design-brief goals (proposed, not scheduled)

`GAME PROMPT.MD` proposes data-driven multi-room maps, room choice/occupancy, richer resource/build/upgrade systems, more objectives and Hunter abilities, stateful/difficulty-scaled AI, original production art/audio, settings and progression, and authoritative online multiplayer with persistence. These should be scoped and designed before implementation; none is implied by this list as done.

## Out of scope for a status claim

No dates, completion estimates, multiplayer deployment plan, public service availability, or feature commitment is verified. See [feature status](FEATURE_STATUS.md) and [known issues](KNOWN_ISSUES.md).
