extends Node2D

func _create_line(start: Vector2, end: Vector2) -> Line2D:
    var line = Line2D.new()
    line.name = "GridLine" + str(start) + "-" + str(end)
    line.width = 2
    line.add_point(start * FieldConfig.cellSize)
    line.add_point(end * FieldConfig.cellSize)
    return line

func _ready() -> void:
    for i in range(0, FieldConfig.fieldSize.x + 1):
        add_child(_create_line(Vector2(i, 0), Vector2(i, FieldConfig.fieldSize.y)))

    for j in range(0, FieldConfig.fieldSize.y + 1):
        add_child(_create_line(Vector2(0, j), Vector2(FieldConfig.fieldSize.x, j)))
