class_name UnitStats
extends Resource

enum Rarity {COMMON, UNCOMMON, RARE, LEGENDARY}
enum Team {PLAYER, ENEMY}

const RARITY_COLORS := {
	Rarity.COMMON: Color("124a2e"),
	Rarity.UNCOMMON: Color("1c527c"),
	Rarity.RARE: Color("ab0979"),
	Rarity.LEGENDARY: Color("ea940b"),
}

const TEAM_SPRITESHEET := {
	Team.PLAYER: preload("res://Assets/rogues.png"),
	Team.ENEMY: preload("res://Assets/monsters.png")
}

@export var name: String

@export_category("Data")
@export var rarity: Rarity 
@export var gold_cost := 1

@export_category("Visuals")
@export var skin_coordinates: Vector2i

@export_category("Battle")
@export var team: Team

func _to_string() -> String:
	return name
