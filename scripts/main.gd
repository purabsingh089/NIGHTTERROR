extends Node2D

const BALANCE_PATH := "res://data/balance.json"
const PHASE_SETUP := "SETUP"
const PHASE_PREPARATION := "PREPARATION"
const PHASE_HUNT := "HUNT"
const PHASE_RESULT := "RESULT"
const ROLE_SURVIVOR := "SURVIVOR"
const ROLE_HUNTER := "HUNTER"
const MAP_SIZE := Vector2(960, 540)
const ROOM_RECT := Rect2(80, 70, 300, 400)
const DOOR_RECT := Rect2(380, 235, 24, 70)
const OBJECTIVE_POSITIONS := [Vector2(610, 230), Vector2(610, 410)]
const EXIT_POSITION := Vector2(850, 270)

var balance: Dictionary
var profile := {"version": 1, "survivor_escapes": 0, "hunter_wins": 0}
var resources := 45
var survivor_health := 100
var survivor_alive := true
var survivor_escaped := false
var survivor_bots: Array[Dictionary] = []
var selected_role := ROLE_SURVIVOR
var primary_objective_time := 0.0
var primary_attack_time := 0.0
var hunter_health := 160
var door_health := 120
var door_open_time := 0.0
var objectives_complete := [false, false]
var turret_built := false
var ward_built := false
var game_over := false
var match_phase := PHASE_PREPARATION
var preparation_time_left := 0.0
var hunt_time_left := 0.0
var result_text := ""
var result_detail := ""
var generation_time := 0.0
var hunter_attack_time := 0.0
var hunter_ability_cooldown := 0.0
var hunter_ability_time := 0.0
var hunter_stun_time := 0.0
var survivor_attack_time := 0.0
var turret_attack_time := 0.0
var ward_attack_time := 0.0
var stick_origin := Vector2.ZERO
var stick_touch := -1
var move_input := Vector2.ZERO
var player_position := Vector2(240, 275)
var hunter_position := Vector2(760, 270)
var hunter_target := "door"
var hunter_target_bot_index := -1
var font: Font

func _ready() -> void:
	var file := FileAccess.open(BALANCE_PATH, FileAccess.READ)
	if file == null:
		push_error("Could not read balance data")
		return
	balance = JSON.parse_string(file.get_as_text())
	_load_profile()
	font = ThemeDB.fallback_font
	_setup_input_actions()
	_reset_match()
	match_phase = PHASE_SETUP
	set_process(true)
	set_process_input(true)

func _process(delta: float) -> void:
	if game_over:
		queue_redraw()
		return
	if match_phase == PHASE_SETUP:
		queue_redraw()
		return
	generation_time += delta
	hunter_attack_time += delta
	hunter_ability_cooldown = maxf(hunter_ability_cooldown - delta, 0.0)
	hunter_ability_time = maxf(hunter_ability_time - delta, 0.0)
	hunter_stun_time = maxf(hunter_stun_time - delta, 0.0)
	survivor_attack_time += delta
	primary_attack_time += delta
	turret_attack_time += delta
	ward_attack_time += delta
	door_open_time = maxf(door_open_time - delta, 0.0)
	if generation_time >= balance.room.generation_interval:
		generation_time = 0.0
		resources += 1
	if match_phase == PHASE_PREPARATION:
		preparation_time_left = maxf(preparation_time_left - delta, 0.0)
		if preparation_time_left == 0.0:
			match_phase = PHASE_HUNT
			hunter_attack_time = 0.0
			survivor_attack_time = 0.0
			turret_attack_time = 0.0
			ward_attack_time = 0.0
	if match_phase == PHASE_HUNT:
		hunt_time_left = maxf(hunt_time_left - delta, 0.0)
		if hunt_time_left == 0.0:
			_end_match("THE HUNTER HELD THE NIGHT", "hunter_win")
			queue_redraw()
			return
	move_input = _get_movement_input()
	if selected_role == ROLE_HUNTER:
		if hunter_stun_time <= 0.0:
			var hunter_speed: float = float(balance.hunter.speed)
			if hunter_ability_time > 0.0:
				hunter_speed *= balance.hunter.ability_speed_multiplier
			hunter_position = _move_survivor(hunter_position, move_input, hunter_speed, delta)
	elif survivor_alive and not survivor_escaped:
		player_position = _move_survivor(player_position, move_input, balance.survivor.speed, delta)
	if match_phase == PHASE_HUNT:
		if selected_role == ROLE_HUNTER:
			_update_survivor_bots(delta)
			_update_primary_survivor(delta)
			_hunter_attack_nearby()
		else:
			_update_survivor_bots(delta)
			_update_survivor_defenses()
			_update_hunter(delta)
		_check_team_result()
	queue_redraw()

func _update_survivor_defenses() -> void:
	var turret_position := Vector2(300, 210)
	if turret_built and turret_attack_time >= balance.room.turret_cooldown and turret_position.distance_to(hunter_position) <= balance.room.turret_range:
		turret_attack_time = 0.0
		hunter_health = maxi(hunter_health - balance.room.turret_damage, 0)
	if ward_built and ward_attack_time >= balance.room.ward_cooldown and Vector2(350, 390).distance_to(hunter_position) <= balance.room.ward_range:
		ward_attack_time = 0.0
		hunter_health = maxi(hunter_health - balance.room.ward_damage, 0)
	if hunter_health == 0:
		_end_match("THE HUNTER IS BANISHED", "hunter_banished")

func _update_primary_survivor(delta: float) -> void:
	if not survivor_alive or survivor_escaped:
		return
	var fleeing: bool = player_position.distance_to(hunter_position) < balance["match"]["bot_flee_radius"]
	var objective_index := 0 if not objectives_complete[0] else 1
	var target_position: Vector2 = EXIT_POSITION if _objectives_done() else OBJECTIVE_POSITIONS[objective_index]
	if fleeing:
		primary_objective_time = 0.0
		target_position = player_position + (player_position - hunter_position).normalized() * 120.0
	elif not _objectives_done() and player_position.distance_to(target_position) < 42.0:
		primary_objective_time += delta
		if primary_objective_time >= balance["match"]["bot_objective_seconds"]:
			objectives_complete[objective_index] = true
			primary_objective_time = 0.0
	else:
		primary_objective_time = 0.0
	if _objectives_done() and player_position.distance_to(EXIT_POSITION) < 44.0 and not fleeing:
		_mark_survivor_escaped(false)
		_check_team_result()
		return
	if not fleeing and ROOM_RECT.has_point(player_position):
		target_position = Vector2(ROOM_RECT.end.x + 50.0, DOOR_RECT.get_center().y)
		if player_position.distance_to(DOOR_RECT.get_center()) < 52.0:
			door_open_time = maxf(door_open_time, 0.8)
	var speed: float = float(balance["match"]["bot_speed"])
	if fleeing:
		speed *= balance["match"]["bot_flee_speed_multiplier"]
	player_position = _move_survivor(player_position, (target_position - player_position).normalized(), speed, delta)
	if player_position.distance_to(hunter_position) <= balance["match"]["bot_attack_range"] and primary_attack_time >= balance["match"]["bot_attack_cooldown"]:
		primary_attack_time = 0.0
		hunter_health = maxi(hunter_health - balance["match"]["bot_attack_damage"], 0)
		if hunter_health == 0:
			_end_match("THE HUNTER IS BANISHED", "hunter_banished")

func _hunter_attack_nearby() -> void:
	if hunter_stun_time > 0.0:
		hunter_target = "stunned"
		return
	var target_position := Vector2.ZERO
	var nearest_distance := INF
	hunter_target_bot_index = -1
	if survivor_alive and not survivor_escaped:
		target_position = player_position
		nearest_distance = hunter_position.distance_to(player_position)
	for index in range(survivor_bots.size()):
		var bot: Dictionary = survivor_bots[index]
		if bot["state"] != "active":
			continue
		var distance := hunter_position.distance_to(bot["position"])
		if distance < nearest_distance:
			target_position = bot["position"]
			nearest_distance = distance
			hunter_target_bot_index = index
	if nearest_distance == INF:
		return
	if door_health > 0 and ROOM_RECT.has_point(target_position):
		hunter_target = "door"
		if hunter_position.distance_to(DOOR_RECT.get_center()) <= 42.0 and hunter_attack_time >= balance.hunter.door_attack_cooldown:
			hunter_attack_time = 0.0
			door_health = maxi(door_health - balance.hunter.door_damage, 0)
		return
	hunter_target = "survivor"
	if hunter_attack_time < balance.hunter.attack_cooldown or nearest_distance > balance.hunter.attack_range:
		return
	hunter_attack_time = 0.0
	if hunter_target_bot_index >= 0:
		var target_bot: Dictionary = survivor_bots[hunter_target_bot_index]
		target_bot["health"] = maxi(target_bot["health"] - balance.hunter.attack_damage, 0)
		target_bot["objective_time"] = 0.0
		if target_bot["health"] == 0:
			target_bot["state"] = "eliminated"
		survivor_bots[hunter_target_bot_index] = target_bot
	else:
		survivor_health = maxi(survivor_health - balance.hunter.attack_damage, 0)
		if survivor_health == 0:
			survivor_alive = false

func _reset_survivor_team() -> void:
	survivor_alive = true
	survivor_escaped = false
	survivor_health = balance.survivor.max_health
	survivor_bots.clear()
	for index in range(balance["match"]["survivor_team_size"] - 1):
		var row := index / 3
		var column := index % 3
		var bot_position := Vector2(145 + column * 82, 185 + row * 135)
		survivor_bots.append({"position": bot_position, "health": balance.survivor.max_health, "state": "active", "objective": index % OBJECTIVE_POSITIONS.size(), "objective_time": 0.0, "attack_time": 0.0})

func _update_survivor_bots(delta: float) -> void:
	for index in range(survivor_bots.size()):
		if game_over:
			return
		var bot: Dictionary = survivor_bots[index]
		bot["attack_time"] += delta
		if bot["state"] != "active":
			survivor_bots[index] = bot
			continue
		var bot_position: Vector2 = bot["position"]
		var fleeing: bool = bot_position.distance_to(hunter_position) < balance["match"]["bot_flee_radius"]
		var objective_index: int = bot["objective"]
		if not fleeing and not _objectives_done() and objectives_complete[objective_index]:
			objective_index = (objective_index + 1) % OBJECTIVE_POSITIONS.size()
			bot["objective"] = objective_index
		var target_position: Vector2 = EXIT_POSITION if _objectives_done() else OBJECTIVE_POSITIONS[objective_index]
		var working_on_objective := false
		if fleeing:
			bot["objective_time"] = 0.0
		elif not _objectives_done() and bot_position.distance_to(target_position) < 42.0:
			bot["objective_time"] += delta
			working_on_objective = true
			if bot["objective_time"] >= balance["match"]["bot_objective_seconds"]:
				objectives_complete[objective_index] = true
				bot["objective_time"] = 0.0
				working_on_objective = false
		elif not _objectives_done():
			bot["objective_time"] = 0.0
		survivor_bots[index] = bot
		if _objectives_done():
			target_position = EXIT_POSITION
		if bot_position.distance_to(EXIT_POSITION) < 44.0 and _objectives_done() and not fleeing:
			_mark_survivor_escaped(true, index)
			_check_team_result()
			continue
		var movement_target := bot_position if working_on_objective else target_position
		if fleeing:
			movement_target = bot_position + (bot_position - hunter_position).normalized() * 120.0
		elif ROOM_RECT.has_point(bot_position):
			movement_target = Vector2(430, DOOR_RECT.get_center().y)
			if bot_position.distance_to(DOOR_RECT.get_center()) < 52.0:
				door_open_time = maxf(door_open_time, 0.8)
		elif working_on_objective:
			movement_target = bot_position
		else:
			movement_target = target_position
			if bot_position.distance_to(target_position) < 42.0:
				movement_target = bot_position
				working_on_objective = true

		if working_on_objective:
			movement_target = bot_position
		var direction := (movement_target - bot_position).normalized()
		var bot_speed: float = float(balance["match"]["bot_speed"])
		if fleeing:
			bot_speed *= balance["match"]["bot_flee_speed_multiplier"]
		bot_position = _move_survivor(bot_position, direction, bot_speed, delta)
		bot["position"] = bot_position
		survivor_bots[index] = bot
		_update_bot_attack(bot)

func _update_bot_attack(bot: Dictionary) -> void:
	if bot["attack_time"] < balance["match"]["bot_attack_cooldown"]:
		return
	if bot["position"].distance_to(hunter_position) > balance["match"]["bot_attack_range"]:
		return
	bot["attack_time"] = 0.0
	hunter_health = maxi(hunter_health - balance["match"]["bot_attack_damage"], 0)
	if hunter_health == 0:
		_end_match("THE HUNTER IS BANISHED", "hunter_banished")

func _begin_match() -> void:
	if match_phase != PHASE_SETUP:
		return
	match_phase = PHASE_PREPARATION
	preparation_time_left = balance["match"]["preparation_seconds"]
	hunt_time_left = balance["match"]["hunt_seconds"]

func _activate_hunter_ability() -> void:
	if selected_role != ROLE_HUNTER or match_phase != PHASE_HUNT or hunter_ability_cooldown > 0.0 or hunter_ability_time > 0.0:
		return
	hunter_ability_time = balance.hunter.ability_duration
	hunter_ability_cooldown = balance.hunter.ability_cooldown

func _setup_input_actions() -> void:
	var bindings := {
		"move_left": [KEY_A, KEY_LEFT],
		"move_right": [KEY_D, KEY_RIGHT],
		"move_up": [KEY_W, KEY_UP],
		"move_down": [KEY_S, KEY_DOWN]
	}
	for action in bindings:
		if not InputMap.has_action(action):
			InputMap.add_action(action)
		for keycode in bindings[action]:
			var key_event := InputEventKey.new()
			key_event.keycode = keycode
			InputMap.action_add_event(action, key_event)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and match_phase != PHASE_SETUP and event.position.x < 300 and event.position.y > 300 and stick_touch == -1:
			stick_touch = event.index
			stick_origin = event.position
			move_input = Vector2.ZERO
		elif not event.pressed and event.index == stick_touch:
			stick_touch = -1
			move_input = Vector2.ZERO
		elif event.pressed:
			_handle_action_touch(event.position)
	elif event is InputEventScreenDrag and event.index == stick_touch:
		move_input = (event.position - stick_origin).limit_length(55.0) / 55.0
	elif event is InputEventMouseButton:
		if event.pressed and event.position.x < 300 and event.position.y > 300:
			stick_origin = event.position
		elif event.pressed:
			_handle_action_touch(event.position)
		elif event.button_index == MOUSE_BUTTON_LEFT:
			move_input = Vector2.ZERO
			stick_origin = Vector2.ZERO
	elif event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and stick_origin != Vector2.ZERO:
		if stick_origin.x < 300 and stick_origin.y > 300:
			move_input = (event.position - stick_origin).limit_length(55.0) / 55.0
	elif event is InputEventKey and event.pressed and not event.echo:
		if match_phase == PHASE_SETUP and event.keycode == KEY_1:
			selected_role = ROLE_SURVIVOR
		elif match_phase == PHASE_SETUP and event.keycode == KEY_2:
			selected_role = ROLE_HUNTER
		elif event.keycode == KEY_ENTER or event.keycode == KEY_KP_ENTER or event.keycode == KEY_E:
			_interact()
		elif event.keycode == KEY_SPACE:
			_attack()

func _get_movement_input() -> Vector2:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length_squared() > 0.0:
		return direction
	return move_input

func _handle_action_touch(position: Vector2) -> void:
	if match_phase == PHASE_SETUP:
		if Rect2(110, 245, 300, 80).has_point(position):
			selected_role = ROLE_SURVIVOR
		elif Rect2(550, 245, 300, 80).has_point(position):
			selected_role = ROLE_HUNTER
		elif Rect2(320, 410, 320, 70).has_point(position):
			_begin_match()
		return
	if Rect2(748, 386, 190, 60).has_point(position):
		_attack()
	elif Rect2(748, 456, 190, 60).has_point(position):
		_interact()

func _interact() -> void:
	if match_phase == PHASE_SETUP:
		_begin_match()
		return
	if game_over:
		_reset_match()
		match_phase = PHASE_SETUP
		return
	if selected_role == ROLE_HUNTER:
		_activate_hunter_ability()
		return
	if not survivor_alive or survivor_escaped:
		return
	if match_phase == PHASE_HUNT:
		if _activate_nearby_objective(player_position):
			return
		if _near_escape(player_position) and _objectives_done():
			_mark_survivor_escaped(false)
			_check_team_result()
			return
		if _rescue_nearby_bot():
			return
	if _player_near_door() and door_health > 0 and door_health == balance.room.door_max_health:
		door_open_time = 0.8
		return
	if _player_near_door() and door_health < balance.room.door_max_health:
		if resources >= balance.room.repair_cost:
			resources -= balance.room.repair_cost
			door_health = mini(door_health + balance.room.repair_amount, balance.room.door_max_health)
	elif _player_in_room() and not turret_built:
		if resources >= balance.room.turret_cost:
			resources -= balance.room.turret_cost
			turret_built = true
	elif _player_in_room() and not ward_built:
		if resources >= balance.room.ward_cost:
			resources -= balance.room.ward_cost
			ward_built = true
	else:
		_attack()

func _activate_nearby_objective(position: Vector2) -> bool:
	for index in range(OBJECTIVE_POSITIONS.size()):
		if not objectives_complete[index] and position.distance_to(OBJECTIVE_POSITIONS[index]) < 58.0:
			objectives_complete[index] = true
			return true
	return false

func _rescue_nearby_bot() -> bool:
	if match_phase != PHASE_HUNT or resources < balance["match"]["rescue_cost"]:
		return false
	for index in range(survivor_bots.size()):
		var bot: Dictionary = survivor_bots[index]
		if bot["state"] == "eliminated" and player_position.distance_to(bot["position"]) < 62.0:
			resources -= balance["match"]["rescue_cost"]
			bot["state"] = "active"
			bot["health"] = balance.survivor.max_health
			bot["objective_time"] = 0.0
			bot["attack_time"] = 0.0
			survivor_bots[index] = bot
			return true
	return false

func _nearby_rescue_available() -> bool:
	if match_phase != PHASE_HUNT or resources < balance["match"]["rescue_cost"]:
		return false
	for bot in survivor_bots:
		if bot["state"] == "eliminated" and player_position.distance_to(bot["position"]) < 62.0:
			return true
	return false

func _near_escape(position: Vector2) -> bool:
	return position.distance_to(EXIT_POSITION) < 70.0

func _objectives_done() -> bool:
	return objectives_complete[0] and objectives_complete[1]

func _mark_survivor_escaped(is_bot: bool, bot_index := -1) -> void:
	if is_bot:
		survivor_bots[bot_index]["state"] = "escaped"
	else:
		survivor_escaped = true

func _active_survivor_count() -> int:
	var count := 1 if survivor_alive and not survivor_escaped else 0
	for bot in survivor_bots:
		if bot["state"] == "active":
			count += 1
	return count

func _escaped_survivor_count() -> int:
	var count := 1 if survivor_escaped else 0
	for bot in survivor_bots:
		if bot["state"] == "escaped":
			count += 1
	return count

func _eliminated_survivor_count() -> int:
	return balance["match"]["survivor_team_size"] - _active_survivor_count() - _escaped_survivor_count()

func _check_team_result() -> void:
	if _escaped_survivor_count() >= balance["match"]["survivor_win_count"]:
		_end_match("THE SURVIVORS ESCAPED", "survivor_escape")
	elif _active_survivor_count() == 0:
		_end_match("THE HUNTER ELIMINATED THE TEAM")

func _attack() -> void:
	if match_phase != PHASE_HUNT:
		return
	if selected_role == ROLE_HUNTER:
		if hunter_stun_time > 0.0:
			return
		_hunter_attack_nearby()
		return
	if not survivor_alive or survivor_escaped:
		return
	if survivor_attack_time < balance.survivor.attack_cooldown:
		return
	if player_position.distance_to(hunter_position) <= balance.survivor.attack_range:
		survivor_attack_time = 0.0
		hunter_stun_time = balance.survivor.stun_duration
		hunter_ability_time = 0.0
		hunter_health = maxi(hunter_health - balance.survivor.attack_damage, 0)
		if hunter_health == 0:
			_end_match("THE HUNTER IS BANISHED", "hunter_banished")

func _update_hunter(delta: float) -> void:
	if hunter_stun_time > 0.0:
		hunter_target = "stunned"
		return
	var target_position := Vector2.ZERO
	var nearest_distance := INF
	hunter_target_bot_index = -1
	if survivor_alive and not survivor_escaped:
		target_position = player_position
		nearest_distance = hunter_position.distance_to(player_position)
	for index in range(survivor_bots.size()):
		var bot: Dictionary = survivor_bots[index]
		if bot["state"] != "active":
			continue
		var bot_position: Vector2 = bot["position"]
		var distance := hunter_position.distance_to(bot_position)
		if distance < nearest_distance:
			target_position = bot_position
			nearest_distance = distance
			hunter_target_bot_index = index
	if nearest_distance == INF:
		_check_team_result()
		return
	if door_health > 0 and ROOM_RECT.has_point(target_position):
		target_position = DOOR_RECT.get_center()
		hunter_target = "door"
	else:
		hunter_target = "survivor"
	if hunter_position.distance_to(target_position) > 32.0:
		if hunter_ability_time <= 0.0 and hunter_ability_cooldown <= 0.0 and hunter_position.distance_to(target_position) > 120.0:
			hunter_ability_time = balance.hunter.ability_duration
			hunter_ability_cooldown = balance.hunter.ability_cooldown
		var hunter_speed: float = float(balance.hunter.speed)
		if hunter_ability_time > 0.0:
			hunter_speed *= balance.hunter.ability_speed_multiplier
		hunter_position = _move_survivor(hunter_position, (target_position - hunter_position).normalized(), hunter_speed, delta)
		return
	var attack_cooldown: float = float(balance.hunter.door_attack_cooldown if hunter_target == "door" else balance.hunter.attack_cooldown)
	if hunter_attack_time < attack_cooldown:
		return
	hunter_attack_time = 0.0
	if hunter_target == "door" and door_health > 0:
		door_health = maxi(door_health - balance.hunter.door_damage, 0)
	elif hunter_target_bot_index >= 0:
		var bot: Dictionary = survivor_bots[hunter_target_bot_index]
		bot["health"] = maxi(bot["health"] - balance.hunter.attack_damage, 0)
		bot["objective_time"] = 0.0
		if bot["health"] == 0:
			bot["state"] = "eliminated"
		survivor_bots[hunter_target_bot_index] = bot
	else:
		survivor_health = maxi(survivor_health - balance.hunter.attack_damage, 0)
		if survivor_health == 0:
			survivor_alive = false
	_check_team_result()

func _can_enter_position(position: Vector2, previous_position: Vector2) -> bool:
	if position.x < 35.0 or position.x > MAP_SIZE.x - 35.0 or position.y < 35.0 or position.y > MAP_SIZE.y - 35.0:
		return false
	var inside_room := ROOM_RECT.has_point(position)
	var was_inside_room := ROOM_RECT.has_point(previous_position)
	if was_inside_room != inside_room:
		var crossed_door_wall := (previous_position.x < ROOM_RECT.end.x and position.x >= ROOM_RECT.end.x) or (previous_position.x >= ROOM_RECT.end.x and position.x < ROOM_RECT.end.x)
		if not crossed_door_wall:
			return false
		var crossing_fraction := (ROOM_RECT.end.x - previous_position.x) / (position.x - previous_position.x)
		var crossing_y := lerpf(previous_position.y, position.y, crossing_fraction)
		var at_doorway := crossing_y >= DOOR_RECT.position.y and crossing_y <= DOOR_RECT.end.y
		if not at_doorway or (door_health > 0 and door_open_time <= 0.0):
			return false
	return true

func _move_survivor(position: Vector2, direction: Vector2, speed: float, delta: float) -> Vector2:
	var next_position := position + direction.limit_length(1.0) * speed * delta
	if _can_enter_position(next_position, position):
		return next_position
	var horizontal_position := Vector2(next_position.x, position.y)
	var vertical_position := Vector2(position.x, next_position.y)
	if _can_enter_position(horizontal_position, position):
		position.x = horizontal_position.x
	if _can_enter_position(vertical_position, position):
		position.y = vertical_position.y
	return position

func _player_in_room() -> bool:
	return ROOM_RECT.has_point(player_position)

func _player_near_door() -> bool:
	return player_position.distance_to(DOOR_RECT.get_center()) < 95.0

func _player_near_hunter() -> bool:
	return player_position.distance_to(hunter_position) <= balance.survivor.attack_range

func _hunter_target_label() -> String:
	if hunter_target == "stunned":
		return "STUNNED %0.1fs" % hunter_stun_time
	if hunter_target == "door":
		return "BREAKING DOOR"
	if selected_role == ROLE_HUNTER:
		if hunter_target_bot_index >= 0:
			return "HUNTING SURVIVOR %d" % (hunter_target_bot_index + 2)
		return "HUNTING SURVIVOR 1"
	if hunter_target_bot_index >= 0:
		return "HUNTING ALLY %d" % (hunter_target_bot_index + 1)
	return "HUNTING YOU"

func _end_match(message: String, outcome := "hunter_win") -> void:
	if game_over:
		return
	game_over = true
	match_phase = PHASE_RESULT
	result_text = message
	result_detail = "TEAM %d ACTIVE  /  %d ESCAPED  /  %d ELIMINATED" % [_active_survivor_count(), _escaped_survivor_count(), _eliminated_survivor_count()]
	if outcome == "survivor_escape":
		profile.survivor_escapes += 1
	elif outcome == "hunter_win":
		profile.hunter_wins += 1
	_save_profile()

func _load_profile() -> void:
	if not FileAccess.file_exists("user://profile.json"):
		return
	var file := FileAccess.open("user://profile.json", FileAccess.READ)
	if file == null:
		return
	var loaded = JSON.parse_string(file.get_as_text())
	if loaded is Dictionary and loaded.get("version") == 1 and loaded.get("survivor_escapes") is int and loaded.get("hunter_wins") is int:
		profile = loaded

func _save_profile() -> void:
	var file := FileAccess.open("user://profile.json", FileAccess.WRITE)
	if file != null:
		file.store_string(JSON.stringify(profile))

func _reset_match() -> void:
	resources = 45
	hunter_health = balance.hunter.max_health
	match_phase = PHASE_PREPARATION
	preparation_time_left = balance["match"]["preparation_seconds"]
	hunt_time_left = balance["match"]["hunt_seconds"]
	generation_time = 0.0
	hunter_attack_time = 0.0
	survivor_attack_time = 0.0
	turret_attack_time = 0.0
	ward_attack_time = 0.0
	hunter_ability_cooldown = 0.0
	hunter_ability_time = 0.0
	hunter_stun_time = 0.0
	primary_objective_time = 0.0
	primary_attack_time = 0.0
	door_health = balance.room.door_max_health
	door_open_time = 0.0
	objectives_complete = [false, false]
	turret_built = false
	ward_built = false
	player_position = Vector2(240, 275)
	hunter_position = Vector2(760, 270)
	hunter_target = "door"
	hunter_target_bot_index = -1
	_reset_survivor_team()
	game_over = false
	result_text = ""
	result_detail = ""
	move_input = Vector2.ZERO
	stick_origin = Vector2.ZERO
	stick_touch = -1

func _draw() -> void:
	_draw_map()
	_draw_objectives()
	if selected_role == ROLE_HUNTER:
		if survivor_alive and not survivor_escaped:
			_draw_character(player_position, Color("#b9d2ce"), "SURVIVOR 1")
	else:
		if survivor_alive and not survivor_escaped:
			_draw_character(player_position, Color("#b9d2ce"), "YOU")
	for index in range(survivor_bots.size()):
		var bot: Dictionary = survivor_bots[index]
		var bot_state: String = bot["state"]
		var bot_color := Color("#8caaa1") if bot_state == "active" else (Color("#719c89") if bot_state == "escaped" else Color("#53454e"))
		_draw_character(bot["position"], bot_color, ("SURVIVOR %d" % (index + 2)) if selected_role == ROLE_HUNTER else ("ALLY %d" % (index + 1)))
		if bot_state == "active":
			draw_rect(Rect2(bot["position"] + Vector2(-18, 19), Vector2(36, 4)), Color("#342f37"))
			draw_rect(Rect2(bot["position"] + Vector2(-18, 19), Vector2(36.0 * float(bot["health"]) / balance.survivor.max_health, 4)), Color("#719c89"))
			if bot["objective_time"] > 0.0:
				draw_string(font, bot["position"] + Vector2(-25, 32), "WORK", HORIZONTAL_ALIGNMENT_CENTER, 50, 9, Color("#dfbc77"))
	var hunter_color := Color("#d4c26d") if hunter_stun_time > 0.0 else (Color("#c55a82") if hunter_ability_time > 0.0 else Color("#a43b67"))
	_draw_character(hunter_position, hunter_color, "YOU / HUNTER" if selected_role == ROLE_HUNTER else "HUNTER")
	if hunter_stun_time > 0.0:
		draw_arc(hunter_position, 24.0, 0.0, TAU, 32, Color("#f3df91"), 3.0)
	if hunter_ability_time > 0.0:
		draw_arc(hunter_position, 24.0, 0.0, TAU, 32, Color("#e59bb5"), 3.0)
	if turret_built:
		draw_circle(Vector2(300, 210), 15, Color("#dcad67"))
		draw_arc(Vector2(300, 210), balance.room.turret_range, 0.0, TAU, 64, Color(0.86, 0.68, 0.4, 0.12), 1.0)
	if ward_built:
		draw_circle(Vector2(350, 390), 12, Color("#7aa4b0"))
		draw_arc(Vector2(350, 390), balance.room.ward_range, 0.0, TAU, 48, Color(0.38, 0.64, 0.7, 0.12), 1.0)
	_draw_hud()

func _draw_map() -> void:
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("#121318"))
	for x in range(0, 961, 48):
		draw_line(Vector2(x, 0), Vector2(x, 540), Color(1, 1, 1, 0.025), 1.0)
	for y in range(0, 541, 48):
		draw_line(Vector2(0, y), Vector2(960, y), Color(1, 1, 1, 0.025), 1.0)
	draw_rect(ROOM_RECT, Color("#29272d"))
	draw_rect(ROOM_RECT, Color("#594b55"), false, 4.0)
	draw_rect(Rect2(110, 100, 100, 55), Color("#302b37"))
	draw_string(font, Vector2(122, 134), "REST CHAMBER", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("#b9a2b1"))
	draw_string(font, Vector2(240, 225), "SAFE ROOM", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color("#847b84"))
	draw_rect(DOOR_RECT, Color("#6f4846") if door_health > 0 else Color("#252329"))
	if door_open_time > 0.0:
		draw_rect(DOOR_RECT, Color(0.72, 0.65, 0.48, 0.35))
	draw_rect(Rect2(590, 180, 190, 150), Color("#1d1c22"), false, 2.0)
	draw_string(font, Vector2(635, 168), "NORTH WING", HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("#6f6874"))
	draw_rect(Rect2(515, 400, 160, 80), Color("#201d25"), false, 2.0)
	draw_string(font, Vector2(548, 444), "DORMITORY", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("#6f6874"))

func _draw_objectives() -> void:
	var positions := [Vector2(610, 230), Vector2(610, 410)]
	for index in range(positions.size()):
		var color := Color("#719c89") if objectives_complete[index] else Color("#c39a5e")
		draw_circle(positions[index], 18, color)
		draw_string(font, positions[index] + Vector2(-44, -28), "POWER %d" % (index + 1), HORIZONTAL_ALIGNMENT_CENTER, 88, 11, Color("#d8cbd3"))
	var exit_color := Color("#719c89") if _objectives_done() else Color("#714b56")
	draw_rect(Rect2(820, 232, 60, 76), exit_color, false, 3.0)
	draw_string(font, Vector2(806, 222), "EXIT", HORIZONTAL_ALIGNMENT_LEFT, 90, 12, Color("#d8cbd3"))

func _draw_character(position: Vector2, color: Color, label: String) -> void:
	draw_circle(position + Vector2(2, 5), 18, Color(0, 0, 0, 0.38))
	draw_circle(position, 15, color)
	draw_circle(position + Vector2(-4, -4), 4, Color(1, 1, 1, 0.42))
	draw_string(font, position + Vector2(-34, -22), label, HORIZONTAL_ALIGNMENT_CENTER, 68, 10, Color("#c4bdc5"))

func _draw_hud() -> void:
	if match_phase == PHASE_SETUP:
		_draw_setup_screen()
		return
	draw_rect(Rect2(14, 14, 330, 138), Color(0.04, 0.04, 0.06, 0.86))
	var timer_label := "PREP %02d" % ceili(preparation_time_left) if match_phase == PHASE_PREPARATION else "HUNT %03d" % ceili(hunt_time_left)
	var role_label := "SURVIVOR" if selected_role == ROLE_SURVIVOR else "HUNTER"
	draw_string(font, Vector2(28, 40), "NIGHTTERROR  /  %s  /  %s" % [role_label, timer_label], HORIZONTAL_ALIGNMENT_LEFT, 300, 14, Color("#dfc7d0"))
	draw_string(font, Vector2(28, 65), "ENERGY  %d" % resources, HORIZONTAL_ALIGNMENT_LEFT, 130, 16, Color("#dfbc77"))
	var health_label := "HUNTER %d    TARGET %d" % [hunter_health, survivor_health] if selected_role == ROLE_HUNTER else "YOU %d    HUNTER %d" % [survivor_health, hunter_health]
	draw_string(font, Vector2(28, 91), health_label, HORIZONTAL_ALIGNMENT_LEFT, 280, 13, Color("#c0b9c2"))
	draw_string(font, Vector2(28, 116), "TEAM  %d ACTIVE  %d OUT  %d LOST" % [_active_survivor_count(), _escaped_survivor_count(), _eliminated_survivor_count()], HORIZONTAL_ALIGNMENT_LEFT, 300, 12, Color("#a89da8"))
	var objective_progress := ""
	for bot in survivor_bots:
		if bot["state"] == "active" and bot["objective_time"] > 0.0:
			objective_progress = "   WORK %d%%" % roundi(100.0 * bot["objective_time"] / balance["match"]["bot_objective_seconds"])
			break
	draw_string(font, Vector2(28, 140), "POWER %s   EXIT %s%s" % ["2/2" if _objectives_done() else ("1/2" if objectives_complete[0] or objectives_complete[1] else "0/2"), "OPEN" if _objectives_done() else "LOCKED", objective_progress], HORIZONTAL_ALIGNMENT_LEFT, 300, 12, Color("#d0b8c3"))
	draw_rect(Rect2(394, 21, 192, 12), Color("#342f37"))
	draw_rect(Rect2(394, 21, 192.0 * float(door_health) / balance.room.door_max_health, 12), Color("#a06a6a"))
	draw_string(font, Vector2(394, 50), "ENTRY BARRIER  %d / %d" % [door_health, balance.room.door_max_health], HORIZONTAL_ALIGNMENT_LEFT, 205, 12, Color("#a99ba4"))
	var hunter_speed_label := "SPRINT" if hunter_ability_time > 0.0 else "READY" if hunter_ability_cooldown <= 0.0 else "COOLDOWN %02d" % ceili(hunter_ability_cooldown)
	draw_string(font, Vector2(394, 72), "HUNTER ABILITY  %s" % hunter_speed_label, HORIZONTAL_ALIGNMENT_LEFT, 205, 12, Color("#c989a4"))
	var health_bar_value: float = float(hunter_health) / float(balance.hunter.max_health) if selected_role == ROLE_HUNTER else float(survivor_health) / float(balance.survivor.max_health)
	var health_bar_color := Color("#c989a4") if selected_role == ROLE_HUNTER else Color("#719c89")
	draw_rect(Rect2(394, 88, 192, 8), Color("#342f37"))
	draw_rect(Rect2(394, 88, 192.0 * health_bar_value, 8), health_bar_color)
	var health_title := "HUNTER HEALTH" if selected_role == ROLE_HUNTER else "YOU HEALTH"
	var health_max: int = int(balance.hunter.max_health if selected_role == ROLE_HUNTER else balance.survivor.max_health)
	var health_current := hunter_health if selected_role == ROLE_HUNTER else survivor_health
	draw_string(font, Vector2(394, 112), "%s  %d / %d" % [health_title, health_current, health_max], HORIZONTAL_ALIGNMENT_LEFT, 205, 12, health_bar_color)
	draw_string(font, Vector2(394, 134), _hunter_target_label(), HORIZONTAL_ALIGNMENT_LEFT, 205, 12, Color("#c989a4"))
	var action_label := "SPRINT" if selected_role == ROLE_HUNTER else "INTERACT"
	_draw_button(Rect2(748, 386, 190, 60), "ATTACK", Color("#6c334d"))
	_draw_button(Rect2(748, 456, 190, 60), action_label, Color("#42504e"))
	if selected_role == ROLE_HUNTER:
		draw_string(font, Vector2(100, 515), "HUNT THE SURVIVORS  /  ATTACK NEARBY  /  SPRINT TO CLOSE DISTANCE", HORIZONTAL_ALIGNMENT_LEFT, 750, 14, Color("#c989a4"))
	elif match_phase == PHASE_PREPARATION:
		draw_string(font, Vector2(100, 515), "PREPARE: build defense or repair the entry before the Hunter arrives", HORIZONTAL_ALIGNMENT_LEFT, 630, 14, Color("#aa9da8"))
	elif _nearby_rescue_available():
		draw_string(font, Vector2(100, 515), "RESCUE ALLY  /  INTERACT (%d ENERGY)" % balance["match"]["rescue_cost"], HORIZONTAL_ALIGNMENT_LEFT, 630, 14, Color("#c3aa7a"))
	elif turret_built and not ward_built:
		draw_string(font, Vector2(100, 515), "BUILD SHOCK WARD (%d ENERGY) OR ACTIVATE POWER POINTS" % balance.room.ward_cost, HORIZONTAL_ALIGNMENT_LEFT, 630, 14, Color("#c3aa7a"))
	elif turret_built:
		draw_string(font, Vector2(100, 515), "DEFENSES ONLINE  /  Activate both hallway power points to unlock the exit", HORIZONTAL_ALIGNMENT_LEFT, 630, 14, Color("#c3aa7a"))
	else:
		draw_string(font, Vector2(100, 515), "Build defense in your room (%d energy), then activate both hallway power points" % balance.room.turret_cost, HORIZONTAL_ALIGNMENT_LEFT, 630, 14, Color("#aa9da8"))
	_draw_joystick()
	if game_over:
		draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color(0, 0, 0, 0.72))
		draw_string(font, Vector2(210, 240), result_text, HORIZONTAL_ALIGNMENT_CENTER, 540, 30, Color("#efc9d2"))
		draw_string(font, Vector2(220, 275), result_detail, HORIZONTAL_ALIGNMENT_CENTER, 520, 14, Color("#c9bdc7"))
		draw_string(font, Vector2(280, 315), "TAP INTERACT OR PRESS E TO RESTART", HORIZONTAL_ALIGNMENT_CENTER, 400, 15, Color("#c9bdc7"))

func _draw_setup_screen() -> void:
	draw_rect(Rect2(Vector2.ZERO, MAP_SIZE), Color("#121318"))
	draw_string(font, Vector2(210, 90), "NIGHTTERROR", HORIZONTAL_ALIGNMENT_CENTER, 540, 34, Color("#dfc7d0"))
	draw_string(font, Vector2(210, 125), "OFFLINE NIGHT SHIFT", HORIZONTAL_ALIGNMENT_CENTER, 540, 15, Color("#a89da8"))
	draw_string(font, Vector2(210, 180), "SELECT YOUR ROLE", HORIZONTAL_ALIGNMENT_CENTER, 540, 19, Color("#d0b8c3"))
	var survivor_color := Color("#719c89") if selected_role == ROLE_SURVIVOR else Color("#42504e")
	var hunter_color := Color("#a43b67") if selected_role == ROLE_HUNTER else Color("#593243")
	_draw_button(Rect2(110, 245, 300, 80), "1  SURVIVOR", survivor_color)
	_draw_button(Rect2(550, 245, 300, 80), "2  HUNTER", hunter_color)
	draw_string(font, Vector2(140, 355), "SURVIVOR: lead the team, power both nodes, and escape", HORIZONTAL_ALIGNMENT_LEFT, 680, 13, Color("#b9d2ce"))
	draw_string(font, Vector2(140, 378), "HUNTER: pursue the team, break the entry, and stop four escapes", HORIZONTAL_ALIGNMENT_LEFT, 680, 13, Color("#c989a4"))
	_draw_button(Rect2(320, 410, 320, 70), "START MATCH", Color("#6c5864"))
	draw_string(font, Vector2(280, 515), "KEYBOARD: 1 / 2 SELECT   ENTER OR E START", HORIZONTAL_ALIGNMENT_CENTER, 400, 13, Color("#a89da8"))

func _draw_button(rect: Rect2, label: String, color: Color) -> void:
	draw_rect(rect, Color(0.02, 0.02, 0.03, 0.84))
	draw_rect(rect.grow(-2), color)
	draw_string(font, rect.position + Vector2(0, 37), label, HORIZONTAL_ALIGNMENT_CENTER, rect.size.x, 18, Color("#f1e6ec"))

func _draw_joystick() -> void:
	var center := stick_origin if stick_touch != -1 or (stick_origin != Vector2.ZERO and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) else Vector2(126, 412)
	draw_circle(center, 58, Color(0.85, 0.84, 0.9, 0.09))
	draw_circle(center + move_input * 31.0, 22, Color(0.82, 0.8, 0.86, 0.24))

