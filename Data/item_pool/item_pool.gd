class_name ItemPool
extends Resource

@export var available_items: Array[ItemStats]

var item_pool: Array[ItemStats]


func generate_item_pool() -> void:
	item_pool = []
	
	for item: ItemStats in available_items:
		for i in item.pool_count:
			item_pool.append(item)


func get_random_item_by_rarity(rarity: ItemStats.Rarity) -> ItemStats:
	var items := item_pool.filter(
		func(item: ItemStats):
			return item.rarity == rarity
	)
	
	if items.is_empty():
		return null
	
	var picked_item: ItemStats = items.pick_random()
	item_pool.erase(picked_item)
	
	return picked_item


func add_item(item: ItemStats) -> void:
	item = item.duplicate()
	item_pool.append(item)
