extends Node2D

const FigureGenerator = preload("res://src/components/field/figure_generator/figure_generator.gd")
const CellManager = preload("res://src/components/field/cell_manager/cell_manager.gd")
const RowDebugger = preload("res://src/components/field/row_debugger/row_debugger.gd")

@onready var figure_generator: FigureGenerator = $State/FigureGenerator
@onready var cell_manager: CellManager = $State/CellManager
@onready var row_debugger: RowDebugger = $Level/RowDebugger

func use_next_figure() -> void:
    figure_generator.use_next_figure()

func handle_cells_updated(cells_per_row: Array[int]) -> void:
    figure_generator.use_next_figure()
    row_debugger.show_debug_info(cells_per_row)

func handle_figure_set(figure: GameFigure) -> void:
    cell_manager.set_figure_cells(figure)
