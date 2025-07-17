@tool

extends Node2D

@export var wallsColor: Color = Color(0.5, 0.5, 0.5)
@export var floorColor: Color = Color(0.5, 0.5, 0.5)

@onready var floorArea: StaticBody2D = $FloorArea2D
@onready var floorPolygon: Polygon2D = $FloorArea2D/Polygon2D
@onready var floorCollisionShape: CollisionShape2D = $FloorArea2D/CollisionShape2D

@onready var wallLeftArea: StaticBody2D = $WallLeftArea2D
@onready var wallLeftPolygon: Polygon2D = $WallLeftArea2D/Polygon2D
@onready var wallLeftCollisionShape: CollisionShape2D = $WallLeftArea2D/CollisionShape2D

@onready var wallRightArea: StaticBody2D = $WallRightArea2D
@onready var wallRightPolygon: Polygon2D = $WallRightArea2D/Polygon2D
@onready var wallRightCollisionShape: CollisionShape2D = $WallRightArea2D/CollisionShape2D

func buildWalls() -> void:
    var points: PackedVector2Array = [
        Vector2.ZERO * FieldConfig.cellSize,
        Vector2(1, 0) * FieldConfig.cellSize,
        Vector2(1, FieldConfig.fieldSize.y) * FieldConfig.cellSize,
        Vector2(0, FieldConfig.fieldSize.y) * FieldConfig.cellSize,
    ]

    wallLeftPolygon.polygon = points
    wallLeftPolygon.color = wallsColor
    wallLeftCollisionShape.shape.normal = Vector2.RIGHT
    wallLeftCollisionShape.shape.distance = FieldConfig.cellSize.x
    wallLeftArea.position = Vector2(-1, 0) * FieldConfig.cellSize

    wallRightPolygon.polygon = points
    wallRightPolygon.color = wallsColor
    wallRightCollisionShape.shape.normal = Vector2.LEFT
    wallRightArea.position = Vector2(FieldConfig.fieldSize.x, 0) * FieldConfig.cellSize

func buildFloor() -> void:
    var points: PackedVector2Array = [
        Vector2(-1, 0) * FieldConfig.cellSize,
        Vector2(FieldConfig.fieldSize.x + 1, 0) * FieldConfig.cellSize,
        Vector2(FieldConfig.fieldSize.x + 1, 1) * FieldConfig.cellSize,
        Vector2(-1, 1) * FieldConfig.cellSize,
    ]

    floorPolygon.polygon = points
    floorPolygon.color = floorColor
    floorCollisionShape.shape.normal = Vector2.UP
    floorArea.position = Vector2(0, FieldConfig.fieldSize.y) * FieldConfig.cellSize

func _ready() -> void:
    buildWalls()
    buildFloor()
