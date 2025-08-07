@tool

extends Node2D

@export var color: Color = Color(1, 1, 1, 0.1)

func _create_line(start: Vector2, end: Vector2) -> Line2D:
    var line = Line2D.new()
    line.name = "GridLine" + str(start) + "-" + str(end)
    line.width = 2
    line.default_color = color
    line.add_point(start * FieldConfig.cell_size)
    line.add_point(end * FieldConfig.cell_size)
    return line

func _ready() -> void:
    for i in range(0, FieldConfig.field_size.x + 1):
        add_child(_create_line(Vector2(i, 0), Vector2(i, FieldConfig.field_size.y)))

    for j in range(0, FieldConfig.field_size.y + 1):
        add_child(_create_line(Vector2(0, j), Vector2(FieldConfig.field_size.x, j)))
