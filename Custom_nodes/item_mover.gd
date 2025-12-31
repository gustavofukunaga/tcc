class_name ItemMover
extends Node

@export var play_areas: Array[PlayArea]


func _ready() -> void:
	var items := get_tree().get_nodes_in_group("Items")
	for item: Item in items:
		setup_item(item)


func setup_item(item: Item) -> void:
	item.drag_and_drop.drag_started.connect(_on_item_drag_started.bind(item))
	item.drag_and_drop.drag_canceled.connect(_on_item_drag_canceled.bind(item))
	item.drag_and_drop.dropped.connect(_on_item_dropped.bind(item))


func _set_highlighters(enabled: bool) -> void:
	for play_area: PlayArea in play_areas:
		play_area.tile_highlighter.enabled = enabled


func _get_play_area_for_position(global: Vector2) -> int:
	var dropped_area_index := -1
	
	for i in play_areas.size():
		var tile := play_areas[i].get_tile_from_global(global)
		if play_areas[i].is_tile_in_bounds(tile):
			dropped_area_index = i
	
	return dropped_area_index


func _reset_item_to_starting_position(starting_position: Vector2, item: Item) -> void:
	var i := _get_play_area_for_position(starting_position)
	var tile := play_areas[i].get_tile_from_global(starting_position)
	
	item.reset_after_dragging(starting_position)
	play_areas[i].unit_grid.add_unit(tile, item)


func _move_item(item: Item, play_area: PlayArea, tile: Vector2i) -> void:
	play_area.unit_grid.add_unit(tile, item)
	item.global_position = play_area.get_global_from_tile(tile) - Arena.HALF_CELL_SIZE
	item.reparent(play_area.unit_grid)


func _on_item_drag_started(item: Item) -> void:
	_set_highlighters(true)
	
	var i := _get_play_area_for_position(item.global_position)
	if i > -1:
		var tile := play_areas[i].get_tile_from_global(item.global_position)
		play_areas[i].unit_grid.remove_unit(tile)


func _on_item_drag_canceled(starting_position: Vector2, item: Item) -> void:
	_set_highlighters(false)
	_reset_item_to_starting_position(starting_position, item)


func _on_item_dropped(starting_position: Vector2, item: Item) -> void:
	_set_highlighters(false)

	var old_area_index := _get_play_area_for_position(starting_position)
	var drop_area_index := _get_play_area_for_position(item.get_global_mouse_position())

	if drop_area_index == -1:
		_reset_item_to_starting_position(starting_position, item)
		return

	var old_area := play_areas[old_area_index]
	var old_tile := old_area.get_tile_from_global(starting_position)
	var new_area := play_areas[drop_area_index]
	var new_tile := new_area.get_hovered_tile()
	
	# swap items if we have to
	if new_area.unit_grid.is_tile_occupied(new_tile):
		var old_item: Item = new_area.unit_grid.units[new_tile]
		new_area.unit_grid.remove_unit(new_tile)
		_move_item(old_item, old_area, old_tile)
	
	_move_item(item, new_area, new_tile)
