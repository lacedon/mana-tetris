extends Node2D

@onready var polygon: Polygon2D = $Polygon2D
@onready var collisionPolygon: CollisionPolygon2D = $Area2D/CollisionPolygon2D

func buildWalls() -> void:
    var points: PackedVector2Array = [
        Vector2(-1, 0) * FieldConfig.cellSize,
        Vector2.ZERO,
        Vector2(0, FieldConfig.fieldSize.y) * FieldConfig.cellSize,
        Vector2(FieldConfig.fieldSize.x, FieldConfig.fieldSize.y) * FieldConfig.cellSize,
        Vector2(FieldConfig.fieldSize.x, 0) * FieldConfig.cellSize,
        Vector2(FieldConfig.fieldSize.x + 1, 0) * FieldConfig.cellSize,
        Vector2(FieldConfig.fieldSize.x + 1, FieldConfig.fieldSize.y + 1) * FieldConfig.cellSize,
        Vector2(-1, FieldConfig.fieldSize.y + 1) * FieldConfig.cellSize,
    ]
    polygon.polygon = points
    collisionPolygon.polygon = points

func _ready() -> void:
    polygon.color = Color(0.5, 0.5, 0.5)  # Set a default color for the walls

    buildWalls()
