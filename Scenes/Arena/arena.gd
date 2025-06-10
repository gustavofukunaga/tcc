class_name Arena
extends Node2D

const CELL_SIZE := Vector2(32, 32)
const HALF_CELL_SIZE := Vector2(16, 16)
const QUARTER_CELL_SIZE := Vector2(8, 8)

@onready var item_mover: ItemMover = $ItemMover
@onready var item_spawner: ItemSpawner = $ItemSpawner
@onready var valid_tiles_highlighter: ValidTilesHighlighter = $UnitGroup/ValidTilesHighlighter
@onready var shop: Shop = %Shop

func _ready() -> void:
	item_spawner.item_spawned.connect(item_mover.setup_item)
	item_spawner.item_spawned.connect(valid_tiles_highlighter.setup_item)
	shop.item_bought.connect(item_spawner.spawn_item)
