class_name ValidTilesHighlighter
extends Node

@export var enabled: bool = true : set = _set_enabled
@export var game_area: PlayArea
@export var bench: PlayArea
@export var game_area_highlight_layer: TileMapLayer
@export var bench_highlight_layer: TileMapLayer
@export var tile: Vector2i

@onready var game_area_source_id := game_area.tile_set.get_source_id(0)
@onready var bench_source_id := bench.tile_set.get_source_id(0)


@onready var unit: Unit = $"../Unit"
@onready var unit_2: Unit = $"../Unit2"


var unit_picked: bool = false


func _ready() -> void:
	var units := get_tree().get_nodes_in_group("Units")
	for unit: Unit in units:
		setup_unit(unit)


func setup_unit(unit: Unit) -> void:
	unit.unit_picked.connect(_on_unit_picked)
	unit.unit_dropped.connect(_on_unit_dropped)


func _on_unit_picked() -> void:
	unit_picked = true


func _on_unit_dropped() -> void:
	unit_picked = false


func _highlight_valid_tiles(play_area: PlayArea, highlight: TileMapLayer, source_id: int) -> void:
	var tiles_list := play_area.get_tiles_coord()
	for tile_coord in tiles_list:
		highlight.set_cell(tile_coord, source_id, tile)


func _clear_highlighted_tiles() -> void:
	game_area_highlight_layer.clear()
	bench_highlight_layer.clear()


func _process(_delta: float) -> void:
	if not enabled:
		return

	_clear_highlighted_tiles()
	if unit_picked:
		_highlight_valid_tiles(game_area, game_area_highlight_layer, game_area_source_id)
		_highlight_valid_tiles(bench, bench_highlight_layer, bench_source_id)


func _set_enabled(new_value: bool) -> void:
	enabled = new_value
	
	if not enabled:
		game_area_highlight_layer.clear()
