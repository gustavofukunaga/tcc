class_name ItemSpawner
extends Node

signal item_spawned(item: Item)

const ITEM = preload("res://scenes/item/item.tscn")

@export var item_bench: PlayArea



func _get_first_available_area() -> PlayArea:
	if not item_bench.unit_grid.is_grid_full():
		return item_bench

	return null


func spawn_item(item: ItemStats) -> void:
	var area := _get_first_available_area()
	# TODO in the future, throw a popup error message here!
	assert(area, "No available space to add item to!")
	
	var new_item := ITEM.instantiate()
	var tile := area.unit_grid.get_first_empty_tile()
	area.unit_grid.add_child(new_item)
	area.unit_grid.add_unit(tile, new_item)
	new_item.global_position = area.get_global_from_tile(tile) - Arena.HALF_CELL_SIZE
	new_item.stats = item
	item_spawned.emit(new_item)


#func _ready() -> void:
	#var knife := preload("res://Data/Items/knife.tres")
	#var tween := create_tween()
	#
	#for i in 8:
		#tween.tween_callback(spawn_item.bind(knife))
		#tween.tween_interval(0.5)
