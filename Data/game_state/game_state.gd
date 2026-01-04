class_name GameState
extends Resource

enum Phase {
	PREPARATION, 
	BATTLE
}

const ENEMY_TEST_POSITIONS := {
	1: 
		[
			[ARCHER, Vector2i(7, 0)],
			[ZOMBIE, Vector2i(7, 3)]
		],
	2: 
		[
			[ARCHER, Vector2i(6, 1)],
			[ZOMBIE, Vector2i(6, 3)],
			[TANK, Vector2i(7, 3)]
		],
	3: 
		[
			[ARCHER, Vector2i(6, 1)],
			[ZOMBIE, Vector2i(6, 3)],
			[TANK, Vector2i(7, 0)],
			[TANK_2, Vector2i(7, 3)]
		],
	4: 
		[
			[ARCHER, Vector2i(6, 1)],
			[MAGE, Vector2i(5, 4)],
			[ZOMBIE, Vector2i(6, 3)],
			[TANK, Vector2i(7, 0)],
			[TANK_2, Vector2i(7, 3)]
		],
	5: 
		[
			[ARCHER, Vector2i(6, 1)],
			[MAGE, Vector2i(5, 4)],
			[ZOMBIE, Vector2i(6, 3)],
			[TANK, Vector2i(7, 0)],
			[REAPER, Vector2i(6, 2)],
			[TANK_2, Vector2i(7, 3)]
		],
	6: 
		[
			[ARCHER, Vector2i(6, 1)],
			[MAGE, Vector2i(5, 4)],
			[ZOMBIE, Vector2i(6, 3)],
			[TANK, Vector2i(7, 0)],
			[REAPER, Vector2i(6, 2)],
			[SKELETON, Vector2i(4, 4)],
			[TANK_2, Vector2i(7, 3)]
		]
}

const ARCHER = preload("res://Data/enemies/archer.tres")
const MAGE = preload("res://Data/enemies/mage.tres")
const REAPER = preload("res://Data/enemies/reaper.tres")
const TANK_2 = preload("res://Data/enemies/tank2.tres")
const TANK = preload("res://Data/enemies/tank.tres")
const ZOMBIE := preload("res://data/enemies/zombie.tres")
const SKELETON = preload("res://Data/enemies/skeleton.tres")

const BONUS_GOLD = 20

@export var current_phase: Phase:
	set(value):
		current_phase = value
		changed.emit()

@export var player_stats: PlayerStats

func is_battling() -> bool: 
	return current_phase == Phase.BATTLE

func get_enemy_positions() -> Array:
	return ENEMY_TEST_POSITIONS.get(player_stats.level)
	
func player_won() -> void:
	player_stats.level += 1
	if player_stats.level > 6:
		_game_over()
	
	player_stats.gold += BONUS_GOLD
	print("Level ", player_stats.level, " start")

func enemy_won() -> void:
	_game_over()
	print("Game Over")

func _game_over() -> void:
	player_stats.level = 1
