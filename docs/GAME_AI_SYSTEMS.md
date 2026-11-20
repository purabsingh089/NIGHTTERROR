# Game AI systems

All AI is local, deterministic-style scripted GDScript; there are no cloud model calls or learned policies. Current implementation resides in `scripts/main.gd`.

## Survivor bots

The team reset creates six bot dictionaries with position, health, state, assigned objective, channel time, and attack time. During updates, active bots head toward an incomplete objective, channel while close, switch if their target is already complete, flee when Hunter distance is below the configured radius, attack the Hunter within configured range/cooldown, and head for the exit after both objectives are complete. Eliminated bots can be rescued by the human Survivor. The behavior is a small ruleset, not the many-state AI proposed in `GAME PROMPT.MD`.

## Primary Survivor when human is Hunter

The selected human Hunter faces the primary Survivor controlled by `_update_primary_survivor` plus six bots. The primary Survivor chooses an objective or exit, flees nearby pressure, can channel an objective, attacks at close range, and can move through the same movement helper.

## Hunter AI when human is Survivor

`_update_hunter` chooses the nearest active Survivor or bot; if a Survivor is behind a living barrier, the Hunter targets the doorway. It moves directly toward the target, may use its speed boost when distant, then attacks the target or barrier. It has no patrol/search/investigation states, difficulty levels, limited-information model, or navigation mesh.

## Limits

Movement uses direct direction vectors and a simple map-boundary/door-crossing check. Pathfinding, collision robustness, decision quality, fairness, and balance have not been playtested on device. There is no AI debug view. Proposed AI requirements are in `GAME PROMPT.MD`; as-built status is in [feature status](FEATURE_STATUS.md).
