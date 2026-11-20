# Multiplayer architecture

## Status: not implemented

There is no multiplayer architecture in the game source. The two selectable roles run in one local process against scripted local characters. No lobby, matchmaking, session, transport, authentication, server simulation, reconnect handling, PostgreSQL schema, Nakama integration, or online ranking is present.

The master brief (`GAME PROMPT.MD`) proposes a Nakama/PostgreSQL backend and authoritative server validation. That proposal is not a design that can be assumed to exist. Before implementing it, the project needs an explicit threat model, protocol/state ownership, server-authoritative rules, disconnect behavior, and an integration test plan. Do not label local bots or the practice match as multiplayer.

For the current system boundary, see [API and networking](API_AND_NETWORKING.md) and [offline systems](OFFLINE_SYSTEMS.md).
