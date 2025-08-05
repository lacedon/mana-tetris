extends Node

const CELL_TYPES = preload("res://src/types/cell_types.gd").cellTypes
const FigureNode = preload("res://src/components/figure/figure.gd")
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")
const MathHelpers = preload("res://src/helpers/math.gd")

signal cells_updated

@export var figureNode: FigureNode

func _ready() -> void:
    figureNode.connect(figureNode.figure_set.get_name(), _set_figure_cells)

func _exit_tree() -> void:
    figureNode.disconnect(figureNode.figure_set.get_name(), _set_figure_cells)

func _handle_last_cell_ready() -> void:
    emit_signal(cells_updated.get_name())

func _set_figure_cells(figure: GameFigure) -> void:
    var figurePosition: Vector2 = figureNode.position
    var cellCount: int = figure.cells.size()
    for cellIndex in range(cellCount):
        var cell: GameCell = figure.cells[cellIndex]
        var isLastCell: bool = cellIndex == (cellCount - 1)

        if !cell || cell.cellType == CELL_TYPES.EMPTY:
            continue

        var cellInstance: CellNode = CellScene.instantiate()
        if isLastCell:
            cellInstance.connect(cellInstance.cell_ready.get_name(), _handle_last_cell_ready, CONNECT_ONE_SHOT)

        var cellPosition: Vector2 = figurePosition + figureNode.cells[cellIndex].position
        var cellPositionInField: Vector2 = cellPosition / FieldConfig.cellSize
        cellInstance.name = "Cell" + str(cellPositionInField)
        cellInstance.set_cell_type(cell.cellType)
        cellInstance.position = cellPosition
        add_child(cellInstance)

func handle_row_filled(rowIndexes: Array[int]) -> void:
    var maxRowIndex: int = MathHelpers.getMaxValue(rowIndexes)

    for cell in get_children():
        if !(cell is CellNode): continue

        var cellRowIndex: int = cell.position.y / FieldConfig.cellSize.y
        if rowIndexes.has(cellRowIndex):
            cell.queue_free()
        elif cellRowIndex < maxRowIndex:
            cell.position.y += FieldConfig.cellSize.y

    emit_signal(cells_updated.get_name())
