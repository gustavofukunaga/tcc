@tool
class_name Item
extends Area2D

@export var stats: ItemStats : set = set_stats

@onready var skin: Sprite2D = $Visuals/Skin
@onready var background: Polygon2D = $Visuals/Background
@onready var drag_and_drop: DragAndDrop = $DragAndDrop
@onready var outline_highlighter: OutlineHighlighter = $OutlineHighlighter
@onready var items_handler: ItemsHandler = $ItemsHandler

var hovered_unit: Area2D

signal item_picked
signal item_dropped

func _ready() -> void:
	if not Engine.is_editor_hint():
		drag_and_drop.drag_started.connect(_on_drag_started)
		drag_and_drop.dropped.connect(_on_dropped)
		drag_and_drop.drag_canceled.connect(_on_drag_canceled)
		input_event.connect(_on_input_event)


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


func apply_item_effect() -> void:
	print(stats.name, " dropped on ", hovered_unit.stats.name)
	


func _on_drag_started() -> void:
	item_picked.emit()
	pass


func _on_dropped(_starting_position: Vector2) -> void:
	var units = get_tree().get_nodes_in_group("hovered_unit")
	if units:
		hovered_unit = units[0]
	
	if hovered_unit:
		print(stats.name, " dropped on ", hovered_unit.stats.name)
		items_handler.apply_item_effect(stats, hovered_unit)
		queue_free()
		return

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

func _get_texture_as_atlas() -> Texture:
	var atlas_texture := AtlasTexture.new()
	atlas_texture.atlas = skin.texture
	atlas_texture.region = skin.region_rect
	return atlas_texture

func _get_tooltip() -> DetailedTooltip:
	var new_tooltip := TooltipHandler.DETAILED_TOOLTIP.instantiate() as DetailedTooltip
	var data := new_tooltip.DetailedTooltipData.new()
	data.texture = _get_texture_as_atlas()
	data.title = stats.name
	data.description = stats.description
	new_tooltip.setup(data)
	return new_tooltip


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("tooltip"):
		TooltipHandler.popup.show_popup(
			_get_tooltip(),
			get_global_mouse_position()
		)
		get_viewport().set_input_as_handled()
