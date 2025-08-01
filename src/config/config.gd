extends Node

## Size of the field in cells (width, height)
@export var fieldSize: Vector2 = Vector2i(10, 20)

## Size of each cell in pixels (width, height)
@export var cellSize: Vector2 = Vector2(64, 64)

func set_window_size(size: Vector2) -> void:
    get_viewport().get_window().size = size

func _ready() -> void:
    set_window_size(fieldSize * cellSize)
