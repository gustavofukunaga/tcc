class_name ItemStats
extends Resource

enum Rarity {COMMON, UNCOMMON, RARE, LEGENDARY}

const RARITY_COLORS := {
	Rarity.COMMON: Color("124a2e"),
	Rarity.UNCOMMON: Color("1c527c"),
	Rarity.RARE: Color("ab0979"),
	Rarity.LEGENDARY: Color("ea940b"),
}

@export var name: String
@export var type: String

@export_category("Data")
@export var rarity: Rarity 
@export var gold_cost := 1
@export var pool_count := 5

@export_category("Visuals")
@export var skin_coordinates: Vector2i

@export_category("Battle")
@export var max_health: int
@export var health: int
@export var max_mana: int
@export var starting_mana: int
@export var attack_damage: int
@export var ability_power: int
@export var attack_speed: float
@export var armor: int
@export var attack_range: int
@export var melee_attack: PackedScene = preload("res://scenes/_effects/attack_smear_effect.tscn")
@export var ranged_attack: PackedScene
@export var ability: PackedScene


func _to_string() -> String:
	return name
