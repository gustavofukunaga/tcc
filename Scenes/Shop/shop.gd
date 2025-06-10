
class_name Shop
extends Control

signal item_bought(item: ItemStats)

const ITEM_CARD = preload("res://Scenes/Item_Card/item_card.tscn")

@export var item_pool: ItemPool
@export var player_stats: PlayerStats

@onready var shop_cards: VBoxContainer = %ShopCards


func _ready() -> void:
	item_pool.generate_item_pool()
	
	for child: Node in shop_cards.get_children():
		child.queue_free()

	_roll_items()


func _roll_items() -> void:
	for i in 5:
		var rarity := player_stats.get_random_rarity_for_level()
		var new_card: ItemCard = ITEM_CARD.instantiate()
		new_card.item_stats = item_pool.get_random_item_by_rarity(rarity)
		new_card.item_bought.connect(_on_item_bought)
		shop_cards.add_child(new_card)


func _put_back_remaining_to_pool() -> void:
	for item_card: ItemCard in shop_cards.get_children():
		if not item_card.bought:
			item_pool.add_item(item_card.item_stats)
		
		item_card.queue_free()


func _on_item_bought(item: ItemStats) -> void:
	item_bought.emit(item)


func _on_reroll_button_pressed() -> void:
	_put_back_remaining_to_pool()
	_roll_items()
