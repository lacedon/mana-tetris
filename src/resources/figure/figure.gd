extends Resource
class_name GameFigure

@export var size: Vector2i = Vector2i.ZERO
@export var cells: Array[GameCell] = []

func get_area() -> int:
    return size.x * size.y

func get_cell_type(index: int) -> GameCell.CELL_TYPES:
    if index >= 0 && index < cells.size() && cells[index]:
        return cells[index].cellType
    return GameCell.CELL_TYPES.EMPTY
