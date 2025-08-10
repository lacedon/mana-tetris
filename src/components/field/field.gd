extends Node2D

const FigureGenerator = preload("res://src/components/field/figure_generator/figure_generator.gd")
const CellManager = preload("res://src/components/field/cell_manager/cell_manager.gd")
const RowDetector = preload("res://src/components/field/row_detector/row_detector.gd")

@onready var figure_generator: FigureGenerator = $FigureGenerator
@onready var cell_manager: CellManager = $CellManager
@onready var row_detector: RowDetector = $RowDetector

func handle_cells_updated() -> void:
    row_detector.handle_cells_updated()
    figure_generator.use_next_figure()

func handle_row_filled(filled_rows: Array[int]) -> void:
    cell_manager.handle_row_filled(filled_rows)

func handle_figure_set(figure: GameFigure) -> void:
    cell_manager.set_figure_cells(figure)
