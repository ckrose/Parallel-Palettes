extends TileMap

# Place the guild hall as one large atlas tile on the existing outdoor map.
func _ready() -> void:
	set_cell(0, Vector2i(43, 9), 1, Vector2i(0, 0), 0)
