@tool
class_name Item
extends Area2D

@export var stats: ItemStats : set = set_stats

@onready var skin: Sprite2D = $Visuals/Skin
@onready var background: Polygon2D = $Visuals/Background
@onready var drag_and_drop: DragAndDrop = $DragAndDrop
@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter

signal item_picked
signal item_dropped

func _ready() -> void:
	if not Engine.is_editor_hint():
		drag_and_drop.drag_started.connect(_on_drag_started)
		drag_and_drop.dropped.connect(_on_dropped)
		drag_and_drop.drag_canceled.connect(_on_drag_canceled)


func set_stats(value: ItemStats) -> void:
	stats = value
	
	if value == null:
		return
	
	if not is_node_ready():
		await ready
	
	skin.region_rect.position = Vector2(stats.skin_coordinates) * Arena.CELL_SIZE
	background.color = stats.RARITY_COLORS[stats.rarity]


func reset_after_dragging(starting_position: Vector2) -> void:
	global_position = starting_position


func _on_drag_started() -> void:
	item_picked.emit()
	pass


func _on_dropped(starting_position: Vector2) -> void:
	item_dropped.emit()


func _on_drag_canceled(starting_position: Vector2) -> void:
	reset_after_dragging(starting_position)
	item_dropped.emit()


func _on_mouse_entered() -> void:
	if drag_and_drop.dragging:
		return
	
	outline_highlighter.highlight()
	z_index = 1


func _on_mouse_exited() -> void:
	if drag_and_drop.dragging:
		return
	
	outline_highlighter.clear_highlight()
	z_index = 0
