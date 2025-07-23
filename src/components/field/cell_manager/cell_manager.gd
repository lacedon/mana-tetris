extends Node

const FigureNode = preload("res://src/components/figure/figure.gd")
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

signal cells_updated

@export var figureNode: FigureNode

func _ready() -> void:
    figureNode.connect(figureNode.figure_set.get_name(), _set_figure_cells)

func _exit_tree() -> void:
    figureNode.disconnect(figureNode.figure_set.get_name(), _set_figure_cells)

func _set_figure_cells(_figure: GameFigure) -> void:
    var figurePosition: Vector2 = figureNode.position
    for cell in figureNode.get_cells():
        if !cell || cell.cellType == GameCell.CELL_TYPES.EMPTY:
            continue

        var cellInstance: CellNode = CellScene.instantiate()
        cellInstance.name = "Cell"
        cellInstance.set_cell_type(cell.cellType)
        cellInstance.position = figurePosition + cell.get_position()
        add_child(cellInstance)

    emit_signal(cells_updated.get_name())
