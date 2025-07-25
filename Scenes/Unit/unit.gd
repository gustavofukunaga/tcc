@tool
class_name Unit
extends Area2D

@export var stats: UnitStats : set = set_stats

@onready var skin: PackedSprite2D = $Visuals/Skin
@onready var health_bar: ProgressBar = $HealthBar
@onready var drag_and_drop: DragAndDrop = $DragAndDrop
@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter

signal unit_picked
signal unit_dropped

func _ready() -> void:
	if not Engine.is_editor_hint():
		drag_and_drop.drag_started.connect(_on_drag_started)
		drag_and_drop.dropped.connect(_on_dropped)
		drag_and_drop.drag_canceled.connect(_on_drag_canceled)


func set_stats(value: UnitStats) -> void:
	stats = value
	
	if value == null:
		return
	
	if not is_node_ready():
		await ready
	
	skin.coordinates = stats.skin_coordinates


func reset_after_dragging(starting_position: Vector2) -> void:
	global_position = starting_position


func _on_drag_started() -> void:
	unit_picked.emit()
	pass


func _on_dropped(starting_position: Vector2) -> void:
	unit_dropped.emit()


func _on_drag_canceled(starting_position: Vector2) -> void:
	reset_after_dragging(starting_position)
	unit_dropped.emit()


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
