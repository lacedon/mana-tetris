@tool

extends Node2D

@export var walls_color: Color = Color(0.5, 0.5, 0.5)
@export var floor_color: Color = Color(0.5, 0.5, 0.5)

@onready var floor_area_ref: StaticBody2D = $FloorArea2D
@onready var floor_polygon_ref: Polygon2D = $FloorArea2D/Polygon2D
@onready var floor_collision_shape_ref: CollisionShape2D = $FloorArea2D/CollisionShape2D

@onready var wall_left_area_ref: StaticBody2D = $WallLeftArea2D
@onready var wall_left_polygon_ref: Polygon2D = $WallLeftArea2D/Polygon2D
@onready var wall_left_collision_shape_ref: CollisionShape2D = $WallLeftArea2D/CollisionShape2D

@onready var wall_right_area_ref: StaticBody2D = $WallRightArea2D
@onready var wall_right_polygon_ref: Polygon2D = $WallRightArea2D/Polygon2D
@onready var wall_right_collision_shape_ref: CollisionShape2D = $WallRightArea2D/CollisionShape2D

func build_walls() -> void:
    var points: PackedVector2Array = [
        Vector2.ZERO * FieldConfig.cell_size,
        Vector2(1, 0) * FieldConfig.cell_size,
        Vector2(1, FieldConfig.field_size.y) * FieldConfig.cell_size,
        Vector2(0, FieldConfig.field_size.y) * FieldConfig.cell_size,
    ]

    wall_left_polygon_ref.polygon = points
    wall_left_polygon_ref.color = walls_color
    wall_left_collision_shape_ref.shape.normal = Vector2.RIGHT
    wall_left_collision_shape_ref.shape.distance = FieldConfig.cell_size.x
    wall_left_area_ref.position = Vector2(-1, 0) * FieldConfig.cell_size

    wall_right_polygon_ref.polygon = points
    wall_right_polygon_ref.color = walls_color
    wall_right_collision_shape_ref.shape.normal = Vector2.LEFT
    wall_right_area_ref.position = Vector2(FieldConfig.field_size.x, 0) * FieldConfig.cell_size

func build_floor() -> void:
    var points: PackedVector2Array = [
        Vector2(-1, 0) * FieldConfig.cell_size,
        Vector2(FieldConfig.field_size.x + 1, 0) * FieldConfig.cell_size,
        Vector2(FieldConfig.field_size.x + 1, 1) * FieldConfig.cell_size,
        Vector2(-1, 1) * FieldConfig.cell_size,
    ]

    floor_polygon_ref.polygon = points
    floor_polygon_ref.color = floor_color
    floor_collision_shape_ref.shape.normal = Vector2.UP
    floor_area_ref.position = Vector2(0, FieldConfig.field_size.y) * FieldConfig.cell_size

func _ready() -> void:
    build_walls()
    build_floor()
