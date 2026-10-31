NIGHT TERROR

Game Design Document & Technical Production Plan

Version: 1.0
Platform: Android first
Genre: Asymmetric Horror Survival / Strategy
Camera: 2D Top-Down
Art Direction: Dark Horror
Match Format: 1 Hunter vs 7 Survivors
Game Modes: Offline + Online
Business Model: Free-to-play, cosmetic monetization

Game Name "NIGHT TERROR"
---

1. Game Vision

Dream Hunter is a horror-survival game built around asymmetric gameplay.

Every match creates two opposing experiences:

- The Hunter experiences the thrill of tracking and hunting.
- Survivors experience the tension of hiding, building defenses, cooperating and escaping.

The game should combine:

- Room-defense mechanics.
- Real-time player-versus-player combat.
- Character abilities.
- Resource management.
- Competitive progression.
- Unlockable content.
- Offline AI gameplay.

The game should not be a direct copy of Haunted Dorm. It should have its own maps, characters, mechanics, art, identity and progression systems.

2. Core Game Structure

Match configuration

Setting| Value
Total players| 8
Hunters| 1
Survivors| 7
Camera| Top-down
Match duration target| 6–10 minutes
Platform| Android
Online synchronization| Real-time
Offline opponents| AI

Match flow

1. Players enter matchmaking.
2. Eight players are assembled.
3. One player is randomly selected as Hunter.
4. Seven players become Survivors.
5. Players enter the map.
6. Survivors establish their defenses.
7. The Hunter begins hunting.
8. Both sides develop their abilities.
9. The final survival phase begins.
10. The match ends and rewards are distributed.

The matchmaking system should avoid assigning the same player as Hunter repeatedly when possible.

3. Game Modes

A. Offline Mode

Must work without internet access.

Features:

- Single-player matches.
- AI-controlled Hunter.
- AI-controlled Survivors.
- Multiple difficulty settings.
- Practice mode.
- Offline challenges.
- Local progression.
- Local achievements.
- Local match history.

Offline AI should have different personalities and strategies.

Example:

AI type| Behaviour
Beginner| Basic resource collection
Defensive| Focuses on upgrading doors
Aggressive| Leaves rooms to collect resources
Strategic| Prioritizes objectives
Advanced| Adapts to Hunter behaviour

The AI should not use perfect information. It must have realistic limitations and should not know survivor locations without valid tracking information.

B. Online Mode

Requires an internet connection.

Features:

- Real-time multiplayer.
- Quick Match.
- Ranked Match.
- Private Rooms.
- Friends system.
- Player profiles.
- Match history.
- Competitive leaderboards.
- Reconnection support.
- Server-validated match results.

The game should use server-authoritative match logic to prevent players from modifying health, damage, rewards or rankings through their clients.

C. Training Mode

A separate mode for learning:

- Hunter abilities.
- Survivor abilities.
- Defense construction.
- Resource management.
- Map layouts.
- Combat mechanics.

4. Survivor Gameplay

Survivors are the defensive and objective-oriented side.

Their main objective is to survive and complete the required objectives.

Survivor mechanics

Room selection

Players begin in a shared spawn area and must find available rooms.

Rooms contain:

- A defensive door.
- Resource generation space.
- Turret placement areas.
- Upgrade slots.
- Limited defensive structures.

Rooms should not provide absolute safety.

Resource generation

Survivors generate resources through structures and objective completion.

Initial resource types:

Resource| Purpose
Energy| Main construction resource
Metal| Defensive upgrades
Dream Shards| Special abilities

Defensive structures

Initial structures:

1. Basic turret.
2. Rapid-fire turret.
3. Slowdown trap.
4. Healing station.
5. Energy generator.
6. Reinforced door.

Every structure has upgrade levels.

Example:

Door progression

- Level 1: Basic wooden door.
- Level 2: Reinforced door.
- Level 3: Metal security door.
- Level 4: Energy barrier.
- Level 5: Advanced defensive barrier.

Upgrades should have diminishing returns so that fully upgrading one room is not an automatic winning strategy.

Survivor objectives

Survivors should not be allowed to camp indefinitely.

Introduce three objective categories:

- Power restoration: Repair generators around the map.
- Dream stabilizers: Activate special structures.
- Escape preparation: Unlock the final exit.

Completing objectives creates opportunities for cooperation but also exposes survivors to danger.

5. Hunter Gameplay

The Hunter is the offensive role.

The Hunter must locate survivors, destroy defenses and prevent their escape.

Hunter mechanics

- Basic attack.
- Special abilities.
- Tracking.
- Door destruction.
- Structure destruction.
- Movement upgrades.
- Temporary transformations.
- Cooldown management.

The Hunter should have a different progression path from Survivors.

Initial Hunter abilities

Ability| Description
Blood Vision| Reveals nearby survivor locations temporarily
Shadow Blink| Short-distance teleportation
Door Breaker| Increased damage against doors
Nightmare Fog| Creates an area of reduced visibility
Sound Detection| Detects recent survivor activity
Rage Mode| Temporary combat enhancement

For the first release, implement only three active abilities.

Hunter progression

The Hunter earns experience during the match through:

- Successful attacks.
- Destroying structures.
- Tracking survivors.
- Eliminating survivors.
- Interrupting objectives.

Progression should unlock tactical choices, not simply make the Hunter overwhelmingly stronger.

6. Character Classes

Survivor classes

Initial classes:

1. Engineer

- Builds defenses faster.
- Repairs structures.
- Bonus resource efficiency.

2. Medic

- Heals teammates.
- Restores defensive structures.
- Support-oriented gameplay.

3. Scout

- Moves faster.
- Detects nearby danger.
- Can temporarily reveal map information.

4. Technician

- Improves generators.
- Disables certain Hunter traps.
- Specializes in objectives.

Hunter classes

Initial classes:

1. Shadow Hunter

- Teleportation.
- Ambush attacks.
- Stealth-oriented gameplay.

2. Blood Hunter

- Tracking.
- Increased attack pressure.
- Survivor detection.

3. Nightmare Hunter

- Area control.
- Fear effects.
- Defensive disruption.

Classes should have distinct strengths and weaknesses.

7. Map Design

The first map should be an abandoned dormitory.

Map elements

- Eight or more bedrooms.
- Main corridor.
- Central generator room.
- Storage area.
- Medical room.
- Locked passages.
- Escape objective.
- Multiple routes between rooms.

Future maps

1. Abandoned Hospital.
2. Haunted School.
3. Underground Laboratory.
4. Forgotten Hotel.
5. Nightmare Mansion.

Every map should introduce different strategic opportunities.

Maps should be designed with readable top-down navigation, mobile-friendly object sizes and clear collision boundaries.

8. Online Competitive System

Hunter and Survivor ratings must be independent.

Rank tiers

1. Bronze
2. Silver
3. Gold
4. Platinum
5. Diamond
6. Master
7. Nightmare

Each rank can contain multiple divisions.

Rating calculations

Consider:

- Match outcome.
- Individual contribution.
- Opponent skill rating.
- Objective participation.
- Hunter performance.
- Survivor survival and teamwork.

Avoid rewarding meaningless activity such as repeatedly attacking structures without strategic value.

Use a server-side rating system. An Elo-style or Glicko-style rating system is suitable initially.

Seasonal progression

- Seasonal rank resets.
- Competitive rewards.
- Exclusive cosmetic rewards.
- Seasonal leaderboard.
- Match statistics.

Ranked matchmaking should only be enabled after the online game has a sufficiently healthy player population.

9. Progression and Economy

The game should have two types of progression.

Account progression

- Player level.
- Experience.
- Achievements.
- Hunter mastery.
- Survivor mastery.
- Cosmetics.

Match progression

- Temporary resources.
- In-match upgrades.
- Ability unlocks.
- Objective completion.

Do not allow players to purchase competitive damage advantages.

Monetization

Free-to-play with optional cosmetic purchases.

Potential revenue:

- Character skins.
- Hunter appearance packs.
- Victory animations.
- Elimination effects.
- Special visual effects.
- Cosmetic battle pass.

Rewarded advertisements may be used in offline mode, but should not interrupt ranked matches.

10. Mobile UI/UX

The game must be designed specifically for touchscreens.

Main menu

Include:

- Play.
- Offline.
- Online.
- Ranked.
- Characters.
- Inventory.
- Shop.
- Profile.
- Settings.

Gameplay HUD

Survivor HUD:

- Virtual joystick.
- Interact button.
- Build menu.
- Ability buttons.
- Resource counters.
- Objective indicators.
- Health indicator.
- Mini-map.

Hunter HUD:

- Virtual joystick.
- Attack button.
- Three ability buttons.
- Tracking indicators.
- Hunter energy.
- Survivor counter.
- Cooldown indicators.

Use scalable UI layouts for different Android screen sizes.

11. Art Direction

The visual direction should be dark, atmospheric and recognizable.

Visual identity

- Dark blue and purple environments.
- Red lighting for danger.
- Glowing ability effects.
- Animated shadows.
- Atmospheric fog.
- Distinct character silhouettes.
- Readable environmental objects.

Graphics requirements

- 2D top-down perspective.
- Original sprite sheets.
- Animated characters.
- Animated monsters.
- Tile-based environments.
- Particle effects.
- Lighting and shadows.

Target 60 FPS on supported devices, with scalable effects for lower-end Android phones.

The game should prioritize readability over excessive visual effects.

12. Technical Architecture

Recommended stack

Layer| Technology
Game engine| Godot 4
Programming| GDScript
Game rendering| Godot 2D
Physics| Godot 2D Physics
Online backend| Nakama
Multiplayer| Authoritative real-time matches
Backend runtime| Nakama server runtime
Database| PostgreSQL
Android build| Android APK / AAB
Version control| Git

Architecture overview

Android Game Client

- Rendering.
- Controls.
- Animations.
- UI.
- Local AI.
- Offline progression.
- Online connection.

Nakama Backend

- Authentication.
- Matchmaking.
- Match sessions.
- Player profiles.
- Friends.
- Leaderboards.

Authoritative Match Logic

- Player movement validation.
- Damage validation.
- Ability cooldowns.
- Resource calculations.
- Construction validation.
- Match timers.
- Win conditions.

PostgreSQL

- Accounts.
- Match history.
- Rankings.
- Progression.
- Inventory.
- Seasonal statistics.

Offline and online separation

Both modes should share the same gameplay rules and core simulation logic.

Offline:

- Local simulation.
- Local bots.
- Local saves.
- No server dependency.

Online:

- Server-authoritative simulation.
- Real-time state synchronization.
- Server-side progression.
- Validated match rewards.

Do not allow offline save data to directly modify competitive online rankings.

13. Networking Requirements

Online gameplay needs:

- Server-authoritative match simulation.
- Real-time state synchronization.
- Interpolation for remote characters.
- Prediction for responsive movement where appropriate.
- Server-side collision and damage validation.
- Reconnection handling.
- Match timeout handling.
- Player disconnection detection.
- Basic anti-cheat measures.

Use an appropriate network tick rate and test bandwidth consumption before choosing a final value.

A disconnected player should have a short reconnection window. The match should not automatically award victory merely because one player temporarily loses connectivity.

14. Security and Fair Play

Important rules:

- Clients cannot directly award themselves rank points.
- Clients cannot decide their own damage values.
- Clients cannot modify authoritative match resources.
- Match results must be validated.
- Account requests must be authenticated.
- Rate-limit sensitive requests.
- Validate all player inputs.
- Detect impossible movement and suspicious actions.

Competitive rewards should only be granted after the server confirms the match result.

15. Performance Requirements

Target devices should include lower-end Android hardware.

Optimization priorities:

- Sprite batching.
- Object pooling.
- Efficient collision detection.
- Limited particle counts.
- Texture compression.
- Lightweight shaders.
- Controlled network updates.
- Efficient AI simulation.

The eight-player match should be tested with all seven Survivors and the Hunter active simultaneously.

Do not assume that a game running smoothly with two test players will run smoothly with eight.

---

16. Development Roadmap

Phase 1 — Foundation

Deliverables:

- Godot project.
- Android input system.
- Top-down movement.
- Camera.
- Collision.
- Basic map.
- Character animations.

Completion criteria: A character can move around the first map reliably on an Android device.

Phase 2 — Offline Core Gameplay

Deliverables:

- Survivor gameplay.
- Hunter gameplay.
- Room selection.
- Resource generation.
- Door upgrades.
- Turrets.
- Combat.
- Win/loss conditions.

Completion criteria: One complete offline match can be played from beginning to end.

Phase 3 — AI Systems

Deliverables:

- AI Hunter.
- AI Survivors.
- Different difficulty levels.
- Navigation.
- Resource priorities.
- Objective behaviour.
- Basic adaptive strategies.

Completion criteria: Offline matches are playable without internet and provide a meaningful challenge.

Phase 4 — Multiplayer Prototype

Start with a smaller test configuration.

Deliverables:

- Nakama deployment.
- Authentication.
- Matchmaking.
- Real-time player synchronization.
- Server-authoritative combat.
- Match sessions.
- Disconnection handling.

Completion criteria: A small group of real players can complete a synchronized match.

Phase 5 — Full 1v7 Multiplayer

Deliverables:

- Eight-player matches.
- Random Hunter assignment.
- Eight-player map balancing.
- Match performance optimization.
- Server-side validation.
- Reconnection system.

Completion criteria: Eight real players can finish matches without critical synchronization or gameplay errors.

Phase 6 — Competitive Systems

Deliverables:

- Ranked matchmaking.
- Separate Hunter and Survivor ratings.
- Player profiles.
- Match history.
- Leaderboards.
- Seasonal rewards.

Completion criteria: Competitive progression works entirely through validated server results.

Phase 7 — Content and Polish

Deliverables:

- Additional maps.
- More characters.
- Additional abilities.
- Cosmetics.
- Audio.
- Animations.
- Tutorials.
- Settings.
- Accessibility improvements.

Phase 8 — Android Release

Deliverables:

- Performance testing.
- Device compatibility.
- Crash reporting.
- Privacy policy.
- Play Store assets.
- Internal testing.
- Closed testing.
- Production release.

---

17. MVP Scope

The first playable version must remain small.

Feature| First MVP
Camera| Top-down
Map| 1 dormitory
Hunters| 1
Survivor classes| 2
Survivor abilities| 2
Hunter abilities| 3
AI opponents| Yes
Offline gameplay| Yes
Online gameplay| Initial small-scale test
Full 1v7| Later milestone
Ranked| Later milestone
Shop| No
Battle pass| No

The first goal is to establish whether the core gameplay is enjoyable.

18. Testing and Quality Assurance

Test these scenarios:

1. Hunter attacks a Survivor.
2. Survivor upgrades a door.
3. Turret attacks the Hunter.
4. Multiple Survivors cooperate.
5. Hunter uses abilities.
6. Survivor completes an objective.
7. Player disconnects.
8. Player reconnects.
9. Match ends normally.
10. Server restarts during a match.
11. Offline mode works with airplane mode enabled.
12. Offline progress cannot manipulate ranked rewards.

Performance testing must include low-end Android devices.

19. Estimated Development Schedule

Indicative solo-developer estimates:

Milestone| Estimated time
Foundation| 1–2 weeks
Offline core| 2–4 weeks
AI systems| 2–3 weeks
Multiplayer prototype| 3–5 weeks
Full 1v7| 2–4 additional weeks
Ranked systems| 2–3 weeks
Polish and testing| 3–5 weeks

These are planning estimates, not guaranteed delivery dates. A reliable online release can take longer due to networking, balancing and device testing.

20. Final Product Principles

1. Offline gameplay must not require an account or internet connection.
2. Online and offline modes must share the core gameplay rules.
3. Hunter and Survivor must both be enjoyable.
4. Ranked matchmaking must use server-verified results.
5. Players must have multiple strategic options.
6. No pay-to-win competitive advantages.
7. Performance on lower-end Android devices matters.
8. The game must have original art, characters, maps and identity.
9. Multiplayer should be tested progressively before launching full 1v7.
10. Do not sacrifice gameplay quality to add unnecessary features.

FINAL PRODUCT VISION

Dream Hunter should become a mobile horror-survival game where players can enjoy offline matches whenever they want, or enter a competitive online world where real players hunt each other.

The defining experience is the battle between one intelligent human Hunter and seven human Survivors.

Build the gameplay first. Build the competitive ecosystem second.