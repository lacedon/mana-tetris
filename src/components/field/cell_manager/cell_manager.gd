extends Node

const CELL_TYPES = preload("res://src/types/cell_types.gd").cellTypes
const FigureNode = preload("res://src/components/figure/figure.gd")
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

signal cells_updated

@export var figureNode: FigureNode

func _ready() -> void:
    figureNode.connect(figureNode.figure_set.get_name(), _set_figure_cells)

func _exit_tree() -> void:
    figureNode.disconnect(figureNode.figure_set.get_name(), _set_figure_cells)

func _set_figure_cells(figure: GameFigure) -> void:
    var figurePosition: Vector2 = figureNode.position
    for cellIndex in range(figure.cells.size()):
        var cell: GameCell = figure.cells[cellIndex]

        if !cell || cell.cellType == CELL_TYPES.EMPTY:
            continue

        var cellInstance: CellNode = CellScene.instantiate()
        cellInstance.name = "Cell"
        cellInstance.set_cell_type(cell.cellType)
        cellInstance.position = figurePosition + figureNode.cells[cellIndex].position
        add_child(cellInstance)

    emit_signal(cells_updated.get_name())
