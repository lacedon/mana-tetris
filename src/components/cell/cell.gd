extends Node2D

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes
const Collisions = preload("res://src/common/collisions.gd").Collisions

signal cell_ready

@export var cell_type: CellTypes = CellTypes.EMPTY
@export var is_virtual: bool = false

@onready var polygon: Polygon2D = $Polygon2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_polygon: CollisionPolygon2D = $Area2D/CollisionPolygon2D

func _ready() -> void:
    make_rectangle(FieldConfig.cell_size)
    _set_color_by_type()

    if is_virtual:
        area_2d.collision_layer = Collisions.NONE

    emit_signal(cell_ready.get_name())

func make_rectangle(size: Vector2) -> void:
    var corners: PackedVector2Array = [
        Vector2.ZERO,
        Vector2(0, size.y),
        Vector2(size.x, size.y),
        Vector2(size.x, 0)
    ]
    polygon.polygon = corners
    collision_polygon.polygon = corners

func set_cell_type(new_type: CellTypes) -> void:
    cell_type = new_type
    if polygon: _set_color_by_type()

func _set_color_by_type() -> void:
    match cell_type:
        CellTypes.BASE:
            polygon.color = Color(0.5, 0.5, 0.5)
        CellTypes.RANDOM:
            polygon.color = Color(1, 0, 1)
        CellTypes.HEAL:
            polygon.color = Color(0, 1, 0)
        CellTypes.ATTACK:
            polygon.color = Color(1, 0, 0)
        CellTypes.MANA_HEAL:
            polygon.color = Color(0, 0, 1)
        CellTypes.MANA_USAGE:
            polygon.color = Color(1, 1, 0)
        _:
            polygon.color = Color(1, 1, 1) # Default color for unknown types

func get_collision_object() -> CollisionObject2D:
    return area_2d
