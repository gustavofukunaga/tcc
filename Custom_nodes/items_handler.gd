class_name ItemsHandler
extends Node

func apply_item_effect(item: ItemStats, unit: Area2D):
	unit.stats.max_health += item.max_health
	unit.stats.health += item.health
	unit.stats.max_mana = item.max_mana
	#unit.stats.starting_mana += item.starting_mana
	unit.stats.attack_damage += item.attack_damage
	unit.stats.ability_power += item.ability_power
	unit.stats.attack_speed += item.attack_speed
	#unit.stats.armor += item.armor
	unit.stats.attack_range += item.attack_range
	#unit.stats.melee_attack = preload("res://scenes/_effects/attack_smear_effect.tscn")
	#unit.stats.ranged_attack = item.ranged_attack
	if item.ability:
		if unit is BattleUnit:
			unit.ability_spawner.scene = item.ability
		unit.stats.ability = item.ability
	
	if item.type == "Special Ability":
		unit.stats.equipped_ability = item
