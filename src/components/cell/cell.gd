extends Node2D

const CELL_TYPES = preload("res://src/types/cell_types.gd").cellTypes

@export var cellType: CELL_TYPES = CELL_TYPES.EMPTY

@onready var polygon: Polygon2D = $Polygon2D
@onready var area2d: Area2D = $Area2D
@onready var collisionPolygon: CollisionPolygon2D = $Area2D/CollisionPolygon2D

func _ready() -> void:
    make_rectangle(FieldConfig.cellSize)
    _set_color_by_type()

func make_rectangle(size: Vector2) -> void:
    var corners: PackedVector2Array = [
        Vector2.ZERO,
        Vector2(0, size.y),
        Vector2(size.x, size.y),
        Vector2(size.x, 0)
    ]
    polygon.polygon = corners
    collisionPolygon.polygon = corners

func set_cell_type(newType: CELL_TYPES) -> void:
    cellType = newType
    if polygon: _set_color_by_type()

func _set_color_by_type() -> void:
    match cellType:
        CELL_TYPES.BASE:
            polygon.color = Color(0.5, 0.5, 0.5)
        CELL_TYPES.RANDOM:
            polygon.color = Color(1, 0, 1)
        CELL_TYPES.HEAL:
            polygon.color = Color(0, 1, 0)
        CELL_TYPES.ATTACK:
            polygon.color = Color(1, 0, 0)
        CELL_TYPES.MANA_HEAL:
            polygon.color = Color(0, 0, 1)
        CELL_TYPES.MANA_USAGE:
            polygon.color = Color(1, 1, 0)
        _:
            polygon.color = Color(1, 1, 1) # Default color for unknown types

func get_collision_object() -> CollisionObject2D:
    return area2d