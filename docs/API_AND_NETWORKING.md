# API and networking

## Current implementation

No NIGHTTERROR API client, network transport, authentication, WebSocket client, backend endpoint, database connection, or remote match state exists in the tracked project. The game code is local GDScript and local JSON/file storage.

`reference_analysis.md` notes WebSocket URL strings in the reference archive’s `netConfig.json`. Those strings are not NIGHTTERROR endpoints and were not contacted. Their presence does not prove service availability or protocol semantics.

## Future proposal boundary

`GAME PROMPT.MD` proposes Nakama and PostgreSQL for a future authoritative online mode. This is a requirement proposal only; no API contract or networking architecture has been implemented or validated. Any future work must define authentication, match authority, client validation, reconnect behavior, secrets handling, and local-development/deployment boundaries before claiming multiplayer functionality.
