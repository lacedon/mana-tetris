extends Node

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

var cells: Array[CellNode] = []

func _add_missing_cells(figure_area: int) -> void:
    var cell_count = cells.size()
    if cell_count < figure_area:
        for index in range(cell_count, figure_area):
            var cell_instance: CellNode = CellScene.instantiate() as CellNode
            cell_instance.name = "Cell#" + str(index)
            cell_instance.is_virtual = true
            cell_instance.hide()
            cells.append(cell_instance)
            add_child(cell_instance)

func _get_cell_position(rotation_mode: int, index: int, figure_size: Vector2) -> Vector2:
    var x: int = index % int(figure_size.x)
    var y: int = floor(index / figure_size.x)
    if rotation_mode == 1: # 90 degrees
        return Vector2(y, figure_size.x - 1 - x)
    elif rotation_mode == 2: # 180 degrees
        return Vector2(figure_size.x - 1 - x, figure_size.y - 1 - y)
    elif rotation_mode == 3: # 270 degrees
        return Vector2(figure_size.y - 1 - y, x)
    else: # 0 degrees
        return Vector2(x, y)

func _set_up_figure_cells(rotation_mode: int, figure_area: int, figure: GameFigure) -> void:
    for index in range(figure_area):
        var cell_type: CellTypes = figure.get_cell_type(index)
        var cell: CellNode = cells[index]
        if cell_type == CellTypes.EMPTY:
            cell.hide()
        else:
            cell.show()
            cell.set_cell_type(cell_type)
            cell.position = _get_cell_position(rotation_mode, index, figure.size) * FieldConfig.cell_size

func _hide_unused_cells(figure_area: int) -> void:
    for index in range(figure_area, cells.size()):
        cells[index].hide()

func set_up_cells(rotation_mode: int, figure: GameFigure) -> void:
    var figure_area: int = figure.get_area()
    _add_missing_cells(figure_area)
    _set_up_figure_cells(rotation_mode, figure_area, figure)
    _hide_unused_cells(figure_area)

func get_cells() -> Array[CellNode]:
    return cells
