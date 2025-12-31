class_name HealthBar
extends ProgressBar

@export var stats: UnitStats : set = _set_stats


func _set_stats(new_stats: UnitStats) -> void:
	stats = new_stats
	if not stats.changed.is_connected(_on_stats_changed):
		stats.changed.connect(_on_stats_changed)
	_on_stats_changed()


func _on_stats_changed() -> void:
	value = stats.health / float(stats.get_max_health()) * 100
