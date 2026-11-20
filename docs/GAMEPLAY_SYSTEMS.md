# Gameplay systems

## Match state and roles

The runtime state machine in `scripts/main.gd` has `SETUP`, `PREPARATION`, `HUNT`, and `RESULT`. Setup selects Survivor or Hunter. Preparation advances to the hunt on its countdown; hunt timeout ends in a Hunter win. Result interaction resets to setup. Exact durations and victory threshold are in `data/balance.json`.

## Teams and objectives

The Survivor team size is configured as seven. Survivor role means the human controls the primary Survivor and six bots run alongside. Hunter role means the human controls the Hunter while the primary Survivor and six bots are controlled locally. Two fixed power objectives gate one exit; escapes are counted at team level. Bots can complete objectives and seek escape; humans can interact with a nearby node and escape. This is one local match, not network multiplayer.

## Combat and defenses

Survivors and bots can damage the Hunter; the human Survivor hit stuns the Hunter and cancels its speed boost. The Hunter damages individual Survivors and the entry barrier. A turret and shock ward attack the Hunter when built and in range; the Hunter can be banished. Match end and profile outcome recording are handled in `_end_match` in `scripts/main.gd`.

## Economy and interaction

Energy begins at a code-defined starting amount and increases on a configured interval. In the room, a Survivor can build one fixed-position turret and one fixed-position shock ward; near the doorway the player can open a full-health door temporarily or repair a damaged one for energy. During a hunt, interaction can activate a nearby objective, escape if objectives are done, or rescue an eliminated bot at a cost. Exact tunables are in `data/balance.json`; the starting energy is a constant in `scripts/main.gd`.

## Boundaries

There is no room selection, room ownership/capacity, general construction placement, upgrade tree, multi-resource economy, map selection, matchmaking, or network session. Geometry and points are fixed in `scripts/main.gd`. See [feature status](FEATURE_STATUS.md) and [known issues](KNOWN_ISSUES.md) for maturity limits.
