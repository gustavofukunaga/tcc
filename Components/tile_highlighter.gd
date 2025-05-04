class_name TileHighlighter
extends Node

@export var enabled: bool = true : set = _set_enabled
@export var play_area: PlayArea
@export var highlight_layer: TileMapLayer
@export var tile: Vector2i

@onready var source_id := play_area.tile_set.get_source_id(0)

#@onready var unit: Unit = $"../../Unit"
#@onready var unit_2: Unit = $"../../Unit2"
#
#var unit_picked: bool = false
#
#func _ready() -> void:
	#unit.unit_picked.connect(_on_unit_picked)
	#unit_2.unit_picked.connect(_on_unit_picked)
#
#func _on_unit_picked() -> void:
	#unit_picked = true
	#
#func _highlight_valid_tiles() -> void:
	#print("")
	#for i in play_area.get_play_area_size().x:
		#for j in play_area.get_play_area_size().y:
			#highlight_layer.set_cell(Vector2i(i, j), source_id, tile)

func _process(_delta: float) -> void:
	if not enabled:
		return

	var selected_tile := play_area.get_hovered_tile()
	
	if not play_area.is_tile_in_bounds(selected_tile):
		highlight_layer.clear()
		return

	_update_tile(selected_tile)


func _set_enabled(new_value: bool) -> void:
	enabled = new_value
	
	if not enabled and play_area:
		highlight_layer.clear()


func _update_tile(selected_tile: Vector2i) -> void:
	highlight_layer.clear()
	highlight_layer.set_cell(selected_tile, source_id, tile)
