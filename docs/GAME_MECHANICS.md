# Game mechanics

This note describes current code behavior. Tunable values belong to `data/balance.json`; fixed positions, initial resources, and implementation rules are in `scripts/main.gd`.

| Mechanic | Current behavior | Source |
|---|---|---|
| Phases | `SETUP` → `PREPARATION` → `HUNT` → `RESULT`; preparation and hunt durations are balance data | `scripts/main.gd`, `data/balance.json` |
| Team | Configured seven Survivors: one human/primary Survivor plus six bots; Hunter role makes all seven Survivors local AI | `scripts/main.gd`, `data/balance.json` |
| Objectives | Two fixed power points; each human interaction activates a nearby incomplete point; bots channel over time | `scripts/main.gd`, `data/balance.json` |
| Escape | Exit is available after both nodes; each escape changes that Survivor's state; team threshold is configured | `scripts/main.gd`, `data/balance.json` |
| Hunter win | All Survivors eliminated or hunt timer expires | `scripts/main.gd`, `data/balance.json` |
| Hunter banishment | Survivor attacks and defenses can reduce Hunter health to zero and end the match | `scripts/main.gd` |
| Damage | Survivor/Hunter attacks, cooldowns, health, and Survivor stun are balance-driven | `data/balance.json`, `scripts/main.gd` |
| Entry barrier | Fixed barrier health; Hunter damages it, Survivor can temporarily open it, and damaged barrier can be repaired using energy | `data/balance.json`, `scripts/main.gd` |
| Energy | Starts at a source constant and gains one unit per configured generation interval | `scripts/main.gd`, `data/balance.json` |
| Turret / shock ward | Each has a fixed position, one build state, energy cost, range, damage, and cooldown | `data/balance.json`, `scripts/main.gd` |
| Rescue | During hunt, player can spend configured energy near an eliminated bot to reset its state/health/timers | `data/balance.json`, `scripts/main.gd` |
| Hunter sprint | Hunter-role interaction activates a duration-limited speed multiplier with cooldown; AI Hunter also uses a boost when distant | `data/balance.json`, `scripts/main.gd` |
| Profile | Version-1 local JSON stores Survivor escapes and Hunter wins; no online rank is attached | `scripts/main.gd` |

The table intentionally does not duplicate balance numbers. The code is authoritative if this summary becomes stale. Behavior remains device- and gameplay-unverified where noted in [testing](TESTING_DOCUMENTATION.md).
