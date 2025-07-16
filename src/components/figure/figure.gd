extends Node2D

const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

@export var figure: GameFigure

var cells: Array[CellNode] = []
var rotationMode: int = 0

func _add_missing_cells(figureArea: int = figure.get_area()) -> void:
    var cellCount = cells.size()
    if cellCount < figureArea:
        for index in range(cellCount, figureArea):
            var cellInstance: CellNode = CellScene.instantiate() as CellNode
            cellInstance.name = "Cell#" + str(index)
            cellInstance.hide()
            cells.append(cellInstance)
            add_child(cellInstance)

func _get_cell_position(index: int, figureSize: Vector2) -> Vector2:
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

func _set_up_figure_cells(figureArea: int = figure.get_area()) -> void:
    for index in range(figureArea):
        var cellType: GameCell.CELL_TYPES = figure.get_cell_type(index)
        var cell: CellNode = cells[index]
        if cellType == GameCell.CELL_TYPES.EMPTY:
            cell.hide()
        else:
            cell.show()
            cell.set_cell_type(cellType)
            cell.position = _get_cell_position(index, figure.size) * FieldConfig.cellSize

func _hide_unused_cells(figureArea: int = figure.get_area()) -> void:
    for index in range(figureArea, cells.size()):
        cells[index].hide()

func set_figure(newFigure: GameFigure) -> void:
    rotationMode = 0

    figure = newFigure
    var figureArea = figure.get_area()

    _add_missing_cells(figureArea)
    _set_up_figure_cells(figureArea)
    _hide_unused_cells(figureArea)

func move_down_figure() -> void:
    self.position.y += FieldConfig.cellSize.y

func move_figure(xDirection: int) -> void:
    self.position.x += xDirection * FieldConfig.cellSize.x

func rotate_figure() -> void:
    rotationMode = (rotationMode + 1) % 4
    _set_up_figure_cells(figure.get_area())
    pass
