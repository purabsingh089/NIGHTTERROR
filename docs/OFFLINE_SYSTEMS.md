# Offline systems

Offline play is the only implemented match mode. The project requires no account or internet service to enter its local setup and run the scripted match, based on the source architecture; a formal airplane-mode device test is not recorded.

## Role variants

- **Human Survivor:** one human Survivor with six local Survivor bots, against a scripted Hunter.
- **Human Hunter:** one human Hunter against a primary Survivor controlled by local rules and six local Survivor bots.

There is no fully AI-controlled simulation mode or difficulty selector. Bots do not communicate over a network.

## Local persistence

`user://profile.json` contains a version-1 profile with two outcome counts. It does not grant online results or rank. See [database and save](DATABASE_AND_SAVE_SYSTEM.md).

## Network independence boundary

No online authentication, multiplayer sessions, API calls, backend, or database is implemented in NIGHTTERROR. The four WebSocket strings described in `reference_analysis.md` belong to the bundled reference game’s configuration and do not establish a NIGHTTERROR dependency or live service.
