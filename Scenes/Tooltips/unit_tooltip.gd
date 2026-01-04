class_name UnitTooltip
extends VBoxContainer

@export var stats: UnitStats:
	set(value):
		stats = value
		if stats and is_node_ready():
			health_bar.stats = stats
			unit_name.text = stats.name
			stats.changed.connect(_on_stats_changed)
			_on_stats_changed()

#@export var item_handler: ItemHandler:
	#set(value):
		#item_handler = value
		#if item_handler and is_node_ready():
			#item_handler.items_changed.connect(_on_items_changed)
			#_on_items_changed()

@onready var unit_name: Label = %UnitName
@onready var health_bar: HealthBar = %HealthBar
@onready var health_label: Label = %HealthLabel
@onready var item_container: HBoxContainer = %ItemContainer
@onready var unit_stats: VBoxContainer = $UnitStats
@onready var ad_number: Label = $UnitStats/AD/number
@onready var ap_number: Label = $UnitStats/AP/number
@onready var atk_speed_number: Label = $"UnitStats/ATK Speed/number"
@onready var atk_range_number: Label = $"UnitStats/ATK Range/number"



func _ready() -> void:
	stats = self.stats
	var item_ui := item_container.get_child(0) as ItemUI
	item_ui.item = stats.equipped_ability
	_set_unit_stats()
	#item_handler = self.item_handler


func _on_stats_changed() -> void:
	health_label.text = "%s/%s" % [stats.health, stats.get_max_health()]
	_set_unit_stats()

func _set_unit_stats() -> void:
	ad_number.text = str(stats.attack_damage)
	ap_number.text = str(stats.ability_power)
	atk_speed_number.text = str(stats.attack_speed) + " per second"
	atk_range_number.text = str(stats.attack_range)
	
#func _on_items_changed() -> void:
	#for i: int in item_container.get_child_count():
		#var item_ui := item_container.get_child(i) as ItemUI
		#var item: Item = null
		#
		#if i < item_handler.equipped_items.size():
			#item = item_handler.equipped_items[i]
		#
		#item_ui.item = item
