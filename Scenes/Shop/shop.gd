
class_name Shop
extends Control

signal item_bought(item: ItemStats)

@export var player_stats: PlayerStats

@onready var shop_cards: VBoxContainer = %ShopCards


func _ready() -> void:
	for item_card: ItemCard in shop_cards.get_children():
		item_card.item_bought.connect(_on_item_bought)


func _on_item_bought(item: UnitStats) -> void:
	item_bought.emit(item)


func _on_reroll_button_pressed() -> void:
	print("reroll items to new ones!")
