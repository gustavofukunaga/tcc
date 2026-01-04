class_name UnitStats
extends Resource

signal health_reached_zero
signal mana_bar_filled

enum Rarity {COMMON, UNCOMMON, RARE, LEGENDARY}
enum Team {PLAYER, ENEMY}
 
const TARGET := {
	Team.PLAYER: "enemy_units",
	Team.ENEMY: "player_units"
}

const TEAM_SPRITESHEET := {
	Team.PLAYER: preload("res://Assets/rogues.png"),
	Team.ENEMY: preload("res://Assets/monsters.png")
}

const MAX_ATTACK_RANGE := 5
const MANA_PER_ATTACK := 1
const MOVE_ONE_TILE_SPEED := 1.0

@export var name: String


@export_category("Visuals")
@export var skin_coordinates: Vector2i

@export_category("Battle")
@export var team: Team
@export var max_health: int
@export var max_mana: int
@export var starting_mana: int
@export var attack_damage: int
@export var ability_power: int
@export var attack_speed: float
@export var armor: int
@export_range(1, MAX_ATTACK_RANGE) var attack_range: int
@export var melee_attack: PackedScene = preload("res://scenes/_effects/attack_smear_effect.tscn")
@export var ranged_attack: PackedScene = preload("res://Scenes/_projectiles/frod_projectile.tscn")
@export var ability: PackedScene
@export var equipped_ability: ItemStats
#@export var auto_attack_sound: AudioStream

var health: int : set = _set_health
var mana: int : set = _set_mana


func reset_health() -> void:
	if health == 0 or team == Team.ENEMY:
		health = get_max_health()


func reset_mana() -> void:
	mana = starting_mana


func get_max_health() -> int:
	return max_health


func get_attack_damage() -> int:
	return attack_damage


func is_melee() -> bool:
	return attack_range == 1


func get_time_between_attacks() -> float:
	return 1 / attack_speed


func get_team_collision_layer() -> int:
	return team + 1


func get_team_collision_mask() -> int:
	return 2 - team


func _set_health(value: int) -> void:
	if value > max_health:
		return
	
	health = value
	emit_changed()
	
	if health <= 0:
		health_reached_zero.emit()


func _set_mana(value: int) -> void:
	mana = value
	emit_changed()
	
	if mana >= max_mana and max_mana > 0:
		mana_bar_filled.emit()


func _to_string() -> String:
	return name
