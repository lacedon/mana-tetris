extends Node2D

const FigureGenerator = preload("res://src/components/field/figure_generator/figure_generator.gd")
const CellManager = preload("res://src/components/field/cell_manager/cell_manager.gd")

@onready var figureGenerator: FigureGenerator = $FigureGenerator
@onready var cellManager: CellManager = $CellManager

func handle_cells_updated() -> void:
    figureGenerator.use_next_figure()

func handle_row_filled(filledRows: Array[int]) -> void:
    cellManager.handle_row_filled(filledRows)
    pass
