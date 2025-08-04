extends Node2D

const FigureGenerator = preload("res://src/components/field/figure_generator/figure_generator.gd")
const RowDetector = preload("res://src/components/field/row_detector/row_detector.gd")

@onready var figureGenerator: FigureGenerator = $FigureGenerator
@onready var rowDetector: RowDetector = $RowDetector

func handle_calls_updated() -> void:
    figureGenerator.use_next_figure()
