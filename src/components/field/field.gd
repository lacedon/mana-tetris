extends Node2D

const FigureGenerator = preload("res://src/components/field/figure_generator/figure_generator.gd")
const CellManager = preload("res://src/components/field/cell_manager/cell_manager.gd")

@onready var figure_generator_ref: FigureGenerator = $FigureGenerator
@onready var cell_manager_ref: CellManager = $CellManager

func handle_cells_updated() -> void:
    figure_generator_ref.use_next_figure()

func handle_row_filled(filled_rows: Array[int]) -> void:
    cell_manager_ref.handle_row_filled(filled_rows)
    pass
