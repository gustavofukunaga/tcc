class_name PlayerStats
extends Resource

const ROLL_RARITIES := {
	#1:  [UnitStats.Rarity.COMMON],
	1:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.LEGENDARY],
	2:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.LEGENDARY],
	3:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.LEGENDARY],
	#2:  [UnitStats.Rarity.COMMON],
	#3:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON],
	4:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE],
	5:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE],
	6:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE],
	7:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.LEGENDARY],
	8:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.LEGENDARY],
	9:  [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.LEGENDARY],
	10: [UnitStats.Rarity.COMMON, UnitStats.Rarity.UNCOMMON, UnitStats.Rarity.RARE, UnitStats.Rarity.LEGENDARY],
}
const ROLL_CHANCES := {
	#1: [1],
	1: [1.0, 2.0, 4.5, 2.5],
	2: [1.0, 2.0, 4.5, 2.5],
	3: [1.0, 2.0, 4.5, 2.5],
	#2: [1],
	#3: [7.5, 2.5],
	4: [6.5, 3.0, 0.5],
	5: [5.0, 3.5, 1.5],
	6: [4.0, 4.0, 2.0],
	7: [2.75, 4.0, 3.24, 0.1],
	8: [2.5, 3.75, 3.45, 0.3],
	9: [1.75, 2.75, 4.5, 1.0],
	10: [1.0, 2.0, 4.5, 2.5],
}

@export_range(0, 99) var gold: int : set = _set_gold
@export_range(0, 99) var xp: int : set = _set_xp
@export_range(1, 10) var level: int : set = _set_level


func get_random_rarity_for_level() -> ItemStats.Rarity:
	var rng = RandomNumberGenerator.new()
	var array: Array = ROLL_RARITIES[level]
	var weights: PackedFloat32Array = PackedFloat32Array(ROLL_CHANCES[level])

	return array[rng.rand_weighted(weights)]


func _set_gold(value: int) -> void:
	gold = value
	emit_changed()


func _set_xp(value: int) -> void:
	xp = value
	emit_changed()


func _set_level(value: int) -> void:
	level = value
	emit_changed()
