extends Node

## Size of the field in cells (width, height)
@export var field_size: Vector2 = Vector2i(10, 20)

## Size of each cell in pixels (width, height)
@export var cell_size: Vector2 = Vector2(32, 32)

var window_size: Vector2:
    get:
        return (field_size + Vector2(2, 1)) * cell_size

func set_window_size(size: Vector2) -> void:
    get_viewport().get_window().size = size

func _ready() -> void:
    set_window_size(window_size)
