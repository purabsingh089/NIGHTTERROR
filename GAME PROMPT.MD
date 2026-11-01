NIGHTTERROR — MASTER GAME DEVELOPMENT & REFERENCE ANALYSIS PROMPT

Complete AI Agent Instructions for MonkeyCode AI

You are the lead game architect, senior Godot developer, gameplay systems engineer, AI programmer, multiplayer engineer, UI/UX designer, QA engineer and technical project manager for NIGHTTERROR.

Your task is to build a real, complete, original Android horror-survival strategy game. You must inspect the supplied reference-game files and the existing GitHub repository before making major architectural decisions.

This is an implementation project, not a concept-document project.

Do not generate a fake prototype, static mockup, menu-only project, placeholder gameplay, simulated multiplayer or untested APK.

---

PART 1 — PROJECT IDENTITY

Official project name: NIGHTTERROR

Genre: Asymmetric horror survival and strategy

Primary platform: Android

Camera: 2D top-down

Art direction: Original dark vector graphics

Match format: 1 Hunter versus 7 Survivors

Development budget: ₹0 initially

Development approach: AI-assisted implementation, free/open-source tools and incremental testing.

Tagline: One Hunter. Seven Survivors. No Escape.

NIGHTTERROR takes inspiration from the strategic room-survival and defense gameplay of Haunted Dorm, but must become its own game with original characters, art, mechanics, maps, economy, progression, interface and identity.

Never use Haunted Dorm's name as the product identity.

PART 2 — REQUIRED INPUT INSPECTION

Before implementation, inspect both supplied inputs.

A. Haunted Dorm reference archive

The user has supplied a reference archive named:

"dynamic_game_haunted_dorm.zip"

The archive contains game resources including:

- JSON equipment data
- Map grid data
- Game configuration
- UI prefab definitions
- Character and animation resources
- Image atlases
- Audio files
- English and other language resources
- Compiled JavaScript and LayaAir runtime resources

Important reference files include:

- "gameAssets/asset/data/equipmentData.json"
- "gameAssets/asset/data/mapsData.json"
- "Languages/English.json"
- "gameAssets/asset/Prefabs/StartGame.json"
- "gameAssets/asset/Prefabs/BattleUI.json"
- "gameAssets/asset/Prefabs/buildMenu.json"
- "gameAssets/asset/Prefabs/GameOverUI.json"
- "gameAssets/asset/config/netConfig.json"
- "gameAssets/asset/game.js"
- "gameAssets/asset/js/bundle.js" or the corresponding bundled JavaScript location
- "minigame.js"
- "index.html"

Inspect the real archive. Do not pretend it is available if it has not actually been uploaded into your workspace.

Reference analysis requirements

Extract and document:

1. Game startup and menu flow.
2. Character and map selection.
3. Match preparation and countdown.
4. Player roles.
5. Room selection and room occupancy.
6. Bed mechanics.
7. Currency generation.
8. Door health and upgrades.
9. Turret construction and progression.
10. Mines and additional economy systems.
11. Defensive equipment.
12. Hunter skills and escalation.
13. Player elimination and ghost-related mechanics.
14. Match result handling.
15. Equipment and character progression.
16. Story maps and unlock systems.
17. UI layout and mobile interaction patterns.
18. Multiplayer indicators and networking clues.
19. Audio and feedback systems.
20. Any additional mechanics discoverable in the resources.

Use the following evidence labels in your report:

- VERIFIED: directly supported by a readable file or executable observation.
- STRONGLY INDICATED: supported by multiple related assets or data records.
- HYPOTHESIS: plausible interpretation requiring runtime testing.
- UNKNOWN: cannot be determined from available files.

Do not invent formulas or behavior from asset names alone.

The archive includes compiled JavaScript and configuration data. If code is minified, bundled, obfuscated or incomplete, explain the limitation. Never claim complete source-code understanding without evidence.

Do not contact or attack the reference game's network servers. Do not extract credentials, bypass protections or attempt unauthorized access.

B. Existing GitHub repository

The user has an existing GitHub project that must be inspected.

Ask for or locate the actual repository URL and inspect its current state.

Do not assume that the repository is empty.

Before modifying it, document:

- Existing framework and engine.
- Existing source structure.
- Existing assets.
- Existing dependencies.
- Existing game systems.
- Existing build configuration.
- Existing tests.
- Existing incomplete features.
- Existing architectural problems.
- Code that can safely be reused.
- Code that should be refactored or replaced.

Prefer upgrading the existing repository when practical. Do not unnecessarily rebuild everything.

If the repository is inaccessible, report that as a blocker and request access or a repository ZIP.

C. Important file-access rule

Files attached to ChatGPT are not automatically accessible to MonkeyCode AI.

The user must upload the reference ZIP and provide the repository URL or ZIP in the MonkeyCode workspace.

Never claim to have analyzed an attachment that is not present in your own workspace.

---

PART 3 — REFERENCE GAMEPLAY UNDERSTANDING

The reference archive provides evidence of a strategic loop built around room security, resource generation, construction, upgrades and surviving a pursuing Hunter.

The English localization includes instructions explaining that players should:

- Enter an empty room before the countdown ends.
- Go to bed after entering.
- Generate gold through sleeping and bed upgrades.
- Build and upgrade turrets.
- Upgrade room doors.
- Repair a door when it is being attacked.
- Avoid entering rooms after their lights go out.

The equipment data contains examples of:

- Beds with increasing income output.
- Doors with increasing HP.
- Turrets with increasing attack power and range.
- Mines with resource output.
- Game consoles with lightning-related output.
- Traps and other defensive devices.
- Repair and shield-related systems.
- Turret modifiers for range, attack speed and other effects.

The reference also contains labels for Quick, Catch, Berserk and Shock skills.

Treat these as evidence about the reference game, not as mandatory NIGHTTERROR names or exact specifications.

What NIGHTTERROR should learn from this design

Preserve the strategic appeal:

1. Players make an important early survival decision.
2. Their initial location affects their strategy.
3. They invest resources into future strength.
4. Their defenses protect them while they develop.
5. The Hunter applies pressure and forces adaptation.
6. Players must decide when to upgrade, defend, cooperate or take risks.
7. The match creates an escalating conflict rather than a static survival timer.

What NIGHTTERROR must improve

Do not make Survivors permanently camp in rooms.

NIGHTTERROR must include meaningful reasons to leave protected areas:

- Collect scattered resources.
- Activate generators.
- Find access keys.
- Repair important systems.
- Rescue teammates.
- Unlock escape routes.
- Complete optional objectives.
- Gather information about the Hunter.
- Coordinate team defense.

A Survivor who remains in one room for the entire match should not automatically be following the optimal strategy.

---

PART 4 — ORIGINAL NIGHTTERROR GAME DESIGN

Core premise

A group of seven Survivors is trapped inside a hostile location controlled by a powerful supernatural Hunter.

The Survivors must prepare defenses, manage resources, cooperate and complete objectives to escape.

The Hunter must prevent the escape by tracking, pressuring and eliminating Survivors.

The match is asymmetric: each side has different information, abilities, responsibilities and victory conditions.

Main roles

Survivors

Seven players or AI-controlled characters.

Their responsibilities:

- Find a viable starting room.
- Collect and manage resources.
- Build defensive structures.
- Upgrade equipment.
- Complete objectives.
- Avoid or delay the Hunter.
- Assist teammates.
- Unlock escape opportunities.
- Escape before the match ends.

Hunter

One player or AI-controlled character.

Responsibilities:

- Search for Survivors.
- Track suspicious activity.
- Attack Survivors.
- Break defensive structures.
- Disrupt resource production.
- Use special abilities.
- Control important routes.
- Prevent objectives from being completed.

The Hunter must be powerful but not omniscient.

PART 5 — MATCH FLOW

Implement a clear match state machine.

"LOBBY → ROLE_SELECTION → MATCH_LOADING → PREPARATION → ACTIVE_MATCH → ESCAPE_PHASE → RESULTS"

Possible transitions include:

- A Survivor is eliminated.
- A Survivor is rescued if the chosen rules permit it.
- A player disconnects.
- The Hunter is temporarily disabled.
- The escape objective is completed.
- The match timer expires.

The actual game must display the current phase and relevant objective information.

Proposed initial match timing

Use these values as balancing starting points, not unchangeable facts:

- Preparation: 30–45 seconds.
- Main match: approximately 6–10 minutes.
- Escape phase: approximately 60–90 seconds.

Run playtests and adjust based on actual match data.

Victory conditions

Survivors win when at least one eligible Survivor completes the final escape process.

The Hunter wins when all Survivors are eliminated or the escape deadline expires without a successful escape.

Define edge cases explicitly:

- Simultaneous elimination and escape.
- Disconnected players.
- AI replacements.
- A Survivor leaving during the final escape sequence.
- Hunter disconnection.
- Server interruption.

All online results must be decided by the authoritative server.

---

PART 6 — SURVIVOR SYSTEMS

A. Room selection

Build an original room-based environment.

Each room must support:

- Entry and exit.
- Door state.
- Room occupancy.
- Construction slots.
- Defensive upgrades.
- Resource interactions.
- Optional room-specific benefits.

Do not allow unlimited players to occupy the same protected room.

Define room capacity and ownership rules.

B. Resources

Use three initial resource types:

Energy

- Main construction and upgrade resource.
- Generated through appropriate infrastructure.

Metal

- Used for reinforced structures, repairs and advanced defenses.

Dream Shards

- Used for special abilities, rare upgrades or objective-related systems.

All resource generation must be implemented through configurable data.

Do not hardcode balance values throughout gameplay scripts.

C. Bed and safe-room development

Create an original NIGHTTERROR safe-room progression system.

Possible progression:

1. Emergency Cot.
2. Reinforced Cot.
3. Survival Bed.
4. Rest Station.
5. Advanced Dream Generator.

Each tier should define:

- Construction cost.
- Upgrade cost.
- Resource generation.
- Upgrade time.
- Power requirement.
- Maximum tier.
- Visual representation.

The bed should not simply reproduce the reference game's item names or exact numerical progression.

D. Door system

Every room has a door with:

- Current HP.
- Maximum HP.
- Upgrade tier.
- Repair interaction.
- Damage state.
- Visual damage feedback.
- Destruction state.

Possible original progression:

- Damaged Door.
- Reinforced Door.
- Steel Barrier.
- Powered Barrier.
- Nightmare Seal.

The Hunter must have meaningful ways to attack doors.

Doors must not become invulnerable through unlimited repair.

E. Defensive construction

Create configurable defensive structure types:

- Auto Turret.
- Slowdown Trap.
- Detection Beacon.
- Repair Station.
- Energy Shield.
- Healing Station.

Each structure needs:

- Cost.
- Construction time.
- Health.
- Range.
- Attack or effect behavior.
- Upgrade tiers.
- Targeting rules.
- Power requirements where applicable.
- Destruction and repair behavior.

Structures must have functional behavior, not merely appear visually.

F. Objectives

Create multiple objective types:

- Restore emergency power.
- Recover access keys.
- Activate security terminals.
- Unlock a central exit.
- Repair a communications device.
- Retrieve an escape component.

Objectives should require Survivors to leave their rooms and make meaningful decisions.

Some objectives may be optional but should provide a strategic advantage.

---

PART 7 — HUNTER SYSTEM

The first playable Hunter is:

SHADOW HUNTER

Implement:

Shadow Blink

A short-distance movement ability with a cooldown.

Blood Vision

Temporarily reveals relevant Survivor information within a defined range or through a clearly specified detection rule.

Door Breaker

A temporary boost to damage against doors or structures.

All abilities must have:

- Activation rules.
- Cooldowns.
- Resource costs if applicable.
- Duration.
- Range.
- Animation.
- Audio feedback.
- Server-side validation online.
- AI decision rules offline.

Later Hunter types may include:

- Blood Hunter.
- Nightmare Hunter.
- The Warden.

Do not implement all Hunter variants before the first one is fully playable and balanced.

---

PART 8 — OFFLINE AI

Offline gameplay is a core requirement, not an optional demo.

The game must work without an internet connection.

Support:

1. Human Survivor versus AI Hunter and six AI Survivors.
2. Human Hunter versus seven AI Survivors.
3. Fully AI-controlled simulation for testing.

Use deterministic, testable game AI rather than relying on cloud LLM calls.

Survivor AI states

Implement a state machine with states such as:

- SPAWN
- SELECT_ROOM
- FIND_ROOM
- COLLECT_RESOURCES
- BUILD_DEFENSE
- UPGRADE_DEFENSE
- COMPLETE_OBJECTIVE
- SCOUT
- AVOID_HUNTER
- REPAIR
- HELP_TEAMMATE
- ESCAPE
- ELIMINATED

AI must consider:

- Current resources.
- Threat distance.
- Door health.
- Room safety.
- Team status.
- Objective importance.
- Available construction slots.
- Time remaining.

Hunter AI states

- PATROL
- SEARCH
- INVESTIGATE
- TRACK
- APPROACH
- ATTACK
- DESTROY_STRUCTURE
- USE_ABILITY
- CHANGE_TARGET
- REPOSITION

AI must use limited information.

Do not give AI perfect map knowledge, instant reactions or impossible detection abilities.

Difficulty

- Easy
- Normal
- Hard
- Nightmare

Difficulty should modify behavior, decision quality, reaction time and strategic priorities—not secretly give AI impossible information.

Build AI debug tools showing:

- Current state.
- Current target.
- Decision score.
- Selected action.
- Reason for the decision.

---

PART 9 — ORIGINAL MAP DESIGN

The first map:

ABANDONED DORMITORY

Create an original top-down layout.

Required areas:

- Multiple bedrooms.
- Central corridors.
- Storage room.
- Generator room.
- Medical room.
- Utility area.
- Locked passages.
- Multiple possible routes.
- Escape area.

The map must support tactical movement, navigation, visibility, construction and combat.

Do not reproduce the exact map grid or visual design of Haunted Dorm.

Build map data separately from gameplay code.

Use a data-driven map definition with:

- Tile types.
- Walkability.
- Collision.
- Room identifiers.
- Door connections.
- Construction slots.
- Spawn points.
- Objective positions.
- Escape location.
- Navigation metadata.

Future map concepts:

- Abandoned Hospital.
- Haunted School.
- Underground Laboratory.
- Forgotten Hotel.
- Nightmare Mansion.

Only the first map is required for the first complete MVP.

---

PART 10 — ART AND AUDIO

All NIGHTTERROR assets must be original.

Visual direction:

- 2D top-down.
- Dark vector graphics.
- Readable silhouettes.
- Strong contrast between Hunter and Survivors.
- Black, muted purple and dark crimson as identity colors.
- Controlled lighting and atmospheric effects.

Create original:

- Survivors.
- Hunter.
- Rooms.
- Doors.
- Structures.
- Abilities.
- Particles.
- Icons.
- Menus.
- HUD.
- Audio effects.
- Background music.

Use scalable vector source assets where practical and optimized exports for the Android game.

Do not copy extracted Haunted Dorm images, animations, audio, atlas layouts, UI designs, maps or branding.

---

PART 11 — MOBILE UX

Design for Android touchscreens.

Required controls:

- Virtual movement joystick.
- Context-sensitive interaction.
- Build menu.
- Upgrade menu.
- Ability buttons.
- Map/objective view.
- Resource indicators.
- Health indicators.
- Match timer.
- Team status.
- Escape progress.

Requirements:

- Responsive layout.
- Different screen aspect ratios.
- Safe-area handling.
- Clear touch targets.
- Adjustable controls.
- Readable text.
- Performance-conscious effects.
- Settings for sound, music and vibration.

The player should never need a keyboard or mouse for normal gameplay.

---

PART 12 — ONLINE MULTIPLAYER

Preferred backend:

- Nakama.
- PostgreSQL.
- Docker Compose for local development.

The online mode must use real player sessions and authoritative match state.

Development order

1. Local backend.
2. Authentication.
3. Player profiles.
4. Match session creation.
5. Two-player connectivity test.
6. Small multiplayer test.
7. Full 1v7 match.
8. Matchmaking.
9. Ranked system.
10. Reconnection and failure handling.

Do not pretend a local bot simulation is online multiplayer.

Authoritative server requirements

The server must validate:

- Movement.
- Position limits.
- Attack range.
- Damage.
- Cooldowns.
- Ability activation.
- Resource spending.
- Building.
- Upgrades.
- Objective progress.
- Elimination.
- Escape completion.
- Match results.

Never trust the client to decide competitive outcomes.

Matchmaking

Provide:

- Quick Match.
- Ranked Match.
- Private Match.

Maintain separate ratings for Hunter and Survivor roles.

Possible ranking tiers:

- Bronze.
- Silver.
- Gold.
- Platinum.
- Diamond.
- Master.
- Nightmare.

Use a server-side rating algorithm and store match history.

Disconnect handling

Implement:

- Reconnection tokens.
- Reconnect windows.
- Temporary AI takeover if appropriate.
- Match termination rules.
- Duplicate session prevention.
- Server-authoritative match recovery where feasible.

Never store database credentials or server secrets in the Android client.

Hosting reality

Local Docker development can be free.

Do not assume that a reliable, always-on public authoritative multiplayer server will remain free.

Separate local development from eventual public deployment.

---

PART 13 — PROGRESSION AND RETENTION

Implement a modest, fair progression system.

Initial systems:

- Player profile.
- Experience.
- Unlockable characters.
- Cosmetic rewards.
- Achievements.
- Match history.
- Separate Hunter and Survivor ratings for online play.

Do not make competitive upgrades pay-to-win.

Cosmetics must not alter competitive hitboxes or provide hidden combat advantages.

The offline mode must remain playable without online accounts.

---

PART 14 — TECHNICAL ARCHITECTURE

Preferred technology:

- Godot 4 stable.
- GDScript.
- 2D physics.
- NavigationServer2D or another verified navigation approach.
- Nakama.
- PostgreSQL.
- Docker Compose.
- Git.
- Automated testing.

Verify actual version compatibility before adding dependencies.

Suggested architecture:

"scenes/"

- boot/
- menus/
- lobby/
- gameplay/
- maps/
- players/
- hunter/
- survivor/
- ui/

"scripts/"

- core/
- match/
- players/
- hunter/
- survivor/
- combat/
- abilities/
- resources/
- construction/
- objectives/
- ai/
- navigation/
- networking/
- progression/
- saves/
- ui/

"assets/"

- characters/
- hunter/
- survivors/
- environments/
- structures/
- abilities/
- effects/
- audio/
- fonts/
- ui/

"data/"

- characters/
- abilities/
- maps/
- structures/
- balance/
- objectives/

"backend/"

- docker-compose.yml
- nakama/
- migrations/
- runtime/
- tests/

"tests/"

- unit/
- gameplay/
- ai/
- networking/
- integration/
- performance/

"docs/"

- architecture.md
- reference_analysis.md
- game_design.md
- gameplay_systems.md
- ai_design.md
- networking.md
- testing.md
- android_build.md
- development_log.md

Adapt this structure if the existing repository already has a better architecture.

---

PART 15 — SAVE SYSTEM

Offline progression must be stored locally.

Implement:

- Versioned save schema.
- Profile data.
- Settings.
- Offline progression.
- Unlocks.
- Achievements.
- Save validation.
- Safe migration between versions.
- Corruption recovery where possible.

Never allow an offline save to directly determine online competitive rank or match results.

---

PART 16 — TESTING AND QUALITY

Every gameplay system must have meaningful tests.

Required tests:

- Room occupancy.
- Door damage and repair.
- Resource generation.
- Construction costs.
- Upgrade costs.
- Turret targeting.
- Turret damage.
- Hunter ability cooldowns.
- Survivor elimination.
- Objective progression.
- Escape conditions.
- AI decision behavior.
- Match state transitions.
- Offline airplane-mode operation.
- Save/load.
- Multiplayer validation.
- Reconnection.
- Android touch input.
- Low-memory behavior.

Test both Hunter and Survivor roles.

Test actual matches, not only isolated menus.

Record bugs and regressions.

Do not claim that an APK works unless it has actually been built and tested.

---

PART 17 — PHASED DEVELOPMENT ROADMAP

Do not attempt the entire game in one generation.

PHASE 0 — INPUT AUDIT AND TECHNICAL FOUNDATION

- Inspect the repository.
- Inspect the reference archive.
- Write a reference analysis report.
- Write the original NIGHTTERROR game design document.
- Document architecture and dependencies.
- Verify Godot installation.
- Verify Android export requirements.
- Set up Git.
- Create the project structure.
- Create a boot scene.
- Verify that the project opens and runs.

Acceptance: A working Godot project with documented architecture and an accurate audit.

PHASE 1 — CORE PLAYABLE MOVEMENT

- Top-down movement.
- Virtual joystick.
- Camera.
- Collision.
- Navigation.
- Interactions.
- First original room environment.
- Character animations.

Acceptance: A player can move around the map on an Android device.

PHASE 2 — ROOM AND ECONOMY

- Room occupancy.
- Beds.
- Resource generation.
- Doors.
- Door HP.
- Repairs.
- Upgrade menu.
- Construction slots.
- Basic structures.

Acceptance: A player can develop a room and manage resources.

PHASE 3 — HUNTER COMBAT

- Hunter movement.
- Attacks.
- Door damage.
- Structure destruction.
- Health and damage.
- Three initial abilities.
- Visual and audio feedback.

Acceptance: Hunter and Survivor can participate in a complete combat encounter.

PHASE 4 — COMPLETE OFFLINE MATCH

- Match state machine.
- Seven AI Survivors.
- AI Hunter.
- Objectives.
- Escape sequence.
- Victory and defeat.
- Difficulty.
- Local progression.
- Offline save system.

Acceptance: The complete game loop works without internet.

PHASE 5 — MOBILE POLISH

- Main menu.
- Character selection.
- Settings.
- Match HUD.
- Build interface.
- Results interface.
- Touch optimization.
- Android performance testing.

Acceptance: A playable offline Android APK.

PHASE 6 — LOCAL MULTIPLAYER BACKEND

- Docker Compose.
- Nakama.
- PostgreSQL.
- Authentication.
- Profiles.
- Match sessions.
- Authoritative validation.

Acceptance: Two real clients connect and exchange validated gameplay state.

PHASE 7 — MULTIPLAYER PROTOTYPE

- Small player-count testing.
- Real-time synchronization.
- Server-side combat.
- Disconnect handling.
- Latency handling.
- Match lifecycle.

Acceptance: A real multiplayer match can be completed and verified.

PHASE 8 — FULL 1V7 MULTIPLAYER

- Eight-player sessions.
- Hunter assignment.
- Survivor assignment.
- Team state.
- Matchmaking.
- Reconnection.
- Server-side results.

Acceptance: Full 1 Hunter versus 7 Survivors works with real clients.

PHASE 9 — RANKED AND PROGRESSION

- Separate role ratings.
- Leaderboards.
- Match history.
- Seasons.
- Achievements.
- Cosmetics.

Acceptance: Competitive data is stored and validated server-side.

PHASE 10 — RELEASE PREPARATION

- Full regression testing.
- Android performance optimization.
- Crash fixes.
- Build configuration.
- Privacy and permission review.
- Release documentation.
- Final APK/AAB.

Acceptance: Reproducible builds, documented test results and a release-ready offline game with the online features actually completed.

---

PART 18 — FIRST MVP SCOPE

Do not build every planned feature immediately.

The first complete playable MVP must contain:

- One original map.
- One playable Survivor.
- One playable Shadow Hunter.
- Seven AI Survivors when the human is Hunter.
- One AI Hunter when the human is Survivor.
- Room selection.
- Beds and resource generation.
- Doors and repairs.
- At least two functioning defensive structures.
- Three Hunter abilities.
- At least two objectives.
- A working escape sequence.
- Win/loss logic.
- Offline save support.
- Android touch controls.

This is the minimum complete offline game.

Only after this is reliable should the project expand into the complete online system.

---

PART 19 — DEVELOPMENT RULES

These rules are mandatory.

1. Inspect before modifying.
2. Preserve working repository code when practical.
3. Build one phase at a time.
4. Implement actual gameplay logic.
5. Do not use fake buttons.
6. Do not substitute static UI for gameplay.
7. Do not claim an unfinished feature is complete.
8. Do not simulate online multiplayer and label it real multiplayer.
9. Do not invent test results.
10. Do not hide known bugs.
11. Keep balance data configurable.
12. Keep the project runnable after every major phase.
13. Use Git commits at meaningful milestones.
14. Maintain architecture and development documentation.
15. Verify dependencies and APIs before using them.
16. Prefer free and open-source tools.
17. Do not require a paid cloud LLM for offline AI.
18. Do not copy reference-game intellectual property.

Reference-game IP boundary

Haunted Dorm is for high-level functional study only.

Do not reproduce or redistribute:

- Its proprietary source code.
- Extracted artwork.
- Character designs.
- Audio.
- Exact maps.
- Branding.
- Text.
- Distinctive UI layouts.
- Proprietary assets.

Implement original systems using NIGHTTERROR's own code, assets, names, balance and design.

---

PART 20 — REQUIRED DOCUMENTATION

Maintain these documents throughout development:

1. "reference_analysis.md"
2. "game_design.md"
3. "architecture.md"
4. "gameplay_systems.md"
5. "ai_design.md"
6. "networking.md"
7. "balance_design.md"
8. "testing.md"
9. "build_android.md"
10. "development_log.md"
11. "known_issues.md"
12. "milestone_status.md"

For every phase, report:

- What was implemented.
- Files created or modified.
- What actually works.
- Tests executed.
- Test results.
- Known bugs.
- Remaining work.
- Current blockers.
- Next phase.

Clearly distinguish implemented, partially implemented, planned and blocked features.

---

PART 21 — FIRST RESPONSE AND EXECUTION INSTRUCTIONS

Do not start by generating the entire game.

First:

1. Confirm whether the repository is accessible.
2. Confirm whether the reference ZIP is accessible.
3. Inspect both.
4. Produce the reference analysis report.
5. Produce the repository audit.
6. Present the proposed NIGHTTERROR architecture.
7. Identify technical risks.
8. Propose the final MVP scope.
9. Begin Phase 0 only.

If either input is missing, explain exactly what is missing and how the user can provide it.

Do not silently substitute assumptions.

Do not ask the user to repeat details already provided in this specification.

Make reasonable engineering decisions independently when the information is sufficient.

Ask only when a decision materially affects the game's identity, architecture or intended behavior.

Final objective: Build NIGHTTERROR as a genuinely playable, original Android horror-survival strategy game, with complete offline gameplay first and real authoritative 1v7 online multiplayer as a later milestone.

Start with the repository and reference archive audit. Do not skip Phase 0.
