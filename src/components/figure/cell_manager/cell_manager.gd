extends Node

const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

var cells: Array[CellNode] = []

func _add_missing_cells(figureArea: int) -> void:
    var cellCount = cells.size()
    if cellCount < figureArea:
        for index in range(cellCount, figureArea):
            var cellInstance: CellNode = CellScene.instantiate() as CellNode
            cellInstance.name = "Cell#" + str(index)
            cellInstance.isVirtual = true
            cellInstance.hide()
            cells.append(cellInstance)
            add_child(cellInstance)

func _get_cell_position(rotationMode: int, index: int, figureSize: Vector2) -> Vector2:
    var x: int = index % int(figureSize.x)
    var y: int = floor(index / figureSize.x)
    if rotationMode == 1: # 90 degrees
        return Vector2(y, figureSize.x - 1 - x)
    elif rotationMode == 2: # 180 degrees
        return Vector2(figureSize.x - 1 - x, figureSize.y - 1 - y)
    elif rotationMode == 3: # 270 degrees
        return Vector2(figureSize.y - 1 - y, x)
    else: # 0 degrees
        return Vector2(x, y)

func _set_up_figure_cells(rotationMode: int, figureArea: int, figure: GameFigure) -> void:
    for index in range(figureArea):
        var cellType: GameCell.CELL_TYPES = figure.get_cell_type(index)
        var cell: CellNode = cells[index]
        if cellType == GameCell.CELL_TYPES.EMPTY:
            cell.hide()
        else:
            cell.show()
            cell.set_cell_type(cellType)
            cell.position = _get_cell_position(rotationMode, index, figure.size) * FieldConfig.cellSize

func _hide_unused_cells(figureArea: int) -> void:
    for index in range(figureArea, cells.size()):
        cells[index].hide()

func set_up_cells(rotationMode: int, figure: GameFigure) -> void:
    var figureArea: int = figure.get_area()
    _add_missing_cells(figureArea)
    _set_up_figure_cells(rotationMode, figureArea, figure)
    _hide_unused_cells(figureArea)

func get_cells() -> Array[CellNode]:
    return cells
