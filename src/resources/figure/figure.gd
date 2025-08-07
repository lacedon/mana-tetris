extends Resource
class_name GameFigure

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes

@export var size: Vector2i = Vector2i.ZERO
@export var cells: Array[GameCell] = []

func get_area() -> int:
    return size.x * size.y

func get_cell_type(index: int) -> CellTypes:
    if index >= 0 && index < cells.size() && cells[index]:
        return cells[index].cell_type
    return CellTypes.EMPTY
