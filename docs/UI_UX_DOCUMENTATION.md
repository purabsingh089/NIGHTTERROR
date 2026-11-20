# UI and UX

## Current interface

All visual interface elements are drawn procedurally from `scripts/main.gd` using Godot draw calls and the fallback font. The script draws a role-selection setup screen, match HUD, timer, energy and health labels, team state, objective/exit state, barrier bar, role-specific action labels, result overlay, and action buttons.

## Input

Keyboard movement uses WASD or arrow keys. During setup, `1` and `2` select Survivor/Hunter. Enter/E interacts; Space attacks. Touch input uses a virtual joystick and attack/interact action areas. The Hunter maps interaction to sprint. Mouse input supports desktop testing. Touch points are transformed into canvas coordinates before hit testing; setup/action hitboxes share constants with drawn controls.

## Layout constraints

The project uses a fixed 540×960 portrait canvas and canvas-item stretching. There is no implemented device safe-area inset handling, adjustable control placement, settings menu, localization flow, or broad responsive layout. Actual Android touch alignment, text readability, notches/insets, and match start remain device-unverified. Do not describe the current fixed HUD as production mobile UX.

## Visual style

Current shapes and labels are original procedural placeholders/prototype visuals. No sprites, animation system, or dedicated font asset is present. See [asset documentation](ASSET_DOCUMENTATION.md) and [known issues](KNOWN_ISSUES.md).
