extends Node2D

const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

@export var figure: GameFigure

var cells: Array[CellNode] = []

func _add_missing_cells(figureArea: int = figure.get_size()) -> void:
    var cellCount = cells.size()
    if cellCount < figureArea:
        for index in range(cellCount, figureArea):
            var cellInstance: CellNode = CellScene.instantiate() as CellNode
            cellInstance.name = "Cell#" + str(index)
            cellInstance.hide()
            cells.append(cellInstance)
            add_child(cellInstance)

func _set_up_figure_cells(figureArea: int = figure.get_size()) -> void:
    for index in range(figureArea):
        var cellType: GameCell.CELL_TYPES = figure.get_cell_type(index)
        var cell: CellNode = cells[index]
        if cellType == GameCell.CELL_TYPES.EMPTY:
            cell.hide()
        else:
            cell.show()
            cell.set_cell_type(cellType)
            cell.position = Vector2(index % figure.size.x, index / figure.size.x) * FieldConfig.cellSize

func _hide_unused_cells(figureArea: int = figure.get_size()) -> void:
    for index in range(figureArea, cells.size()):
        cells[index].hide()

func set_figure(newFigure: GameFigure) -> void:
    figure = newFigure
    var figureArea = figure.get_area()

    _add_missing_cells(figureArea)
    _set_up_figure_cells(figureArea)
    _hide_unused_cells(figureArea)

func move_down() -> void:
    self.position.y += FieldConfig.cellSize.y
