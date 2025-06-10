class_name ItemCard
extends Button

signal item_bought(item: ItemStats)

const HOVER_BORDER_COLOR := Color("fafa82")

@export var player_stats: PlayerStats
@export var item_stats: ItemStats : set = _set_item_stats

@onready var traits: Label = %Traits
@onready var bottom: Panel = %Bottom
@onready var item_name: Label = %ItemName
@onready var gold_cost: Label = %GoldCost
@onready var border: Panel = %Border
@onready var empty_placeholder: Panel = %EmptyPlaceholder
@onready var item_icon: TextureRect = %ItemIcon
@onready var border_sb: StyleBoxFlat = border.get_theme_stylebox("panel")
@onready var bottom_sb: StyleBoxFlat = bottom.get_theme_stylebox("panel")

var bought := false
var border_color: Color


func _ready() -> void:
	player_stats.changed.connect(_on_player_stats_changed)
	_on_player_stats_changed()
	
	item_bought.connect(
		func(item: ItemStats):
			print("bought item: ", item)
			print("gold: ", player_stats.gold)
	)


func _set_item_stats(value: ItemStats) -> void:
	item_stats = value
	
	if not is_node_ready():
		await ready

	if not item_stats:
		empty_placeholder.show()
		disabled = true
		bought = true
		return

	border_color = ItemStats.RARITY_COLORS[item_stats.rarity]
	border_sb.border_color = border_color
	bottom_sb.bg_color = border_color
	item_name.text = item_stats.name
	gold_cost.text = str(item_stats.gold_cost)
	item_icon.texture.region.position = Vector2(item_stats.skin_coordinates) * Arena.CELL_SIZE


func _on_player_stats_changed() -> void:
	if not item_stats:
		return

	var has_enough_gold := player_stats.gold >= item_stats.gold_cost
	disabled = not has_enough_gold
	
	if has_enough_gold or bought:
		modulate = Color(Color.WHITE, 1.0)
	else:
		modulate = Color(Color.WHITE, 0.5)


func _on_pressed() -> void:
	if bought:
		return
	
	bought = true
	empty_placeholder.show()
	player_stats.gold -= item_stats.gold_cost
	item_bought.emit(item_stats)


func _on_mouse_entered() -> void:
	if not disabled:
		border_sb.border_color = HOVER_BORDER_COLOR


func _on_mouse_exited() -> void:
	border_sb.border_color = border_color
