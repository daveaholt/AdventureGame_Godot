extends Node

var currentTilemapBounds : Array[Vector2]
signal TilemapBoundsChanged(bounds: Array[Vector2])

func ChangeTilemapBounds(bounds: Array[Vector2]) -> void:
	currentTilemapBounds = bounds
	TilemapBoundsChanged.emit(bounds)
	pass
