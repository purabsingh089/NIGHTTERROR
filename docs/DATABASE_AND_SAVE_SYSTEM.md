# Database and save system

## Database

No database engine or database schema is present. NIGHTTERROR has no online service or shared server-side records in the checked-in project.

## Local profile

`scripts/main.gd` reads and writes `user://profile.json`. The current profile schema has `version: 1`, `survivor_escapes`, and `hunter_wins`. It is loaded during startup and saved by `_end_match`. The loader accepts a dictionary only when the version and both integer counters match the expected shape; otherwise the in-memory defaults remain. There is no migration, backup, corruption recovery, settings, unlocks, achievements, or match history.

One outcome nuance: the `hunter_banished` outcome does not increment either stored counter. Only `survivor_escape` increments Survivor escapes and `hunter_win` increments Hunter wins.

## Competitive boundary

These values are local-only. There is no online rank or server result authority, and offline profile data must not be represented as competitive rank. The richer versioned save, unlock, achievement, and history systems in `GAME PROMPT.MD` are proposed, not implemented.
