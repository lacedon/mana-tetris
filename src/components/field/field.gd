extends Node2D

const FigureGenerator = preload("res://src/components/field/figure_generator/figure_generator.gd")

@onready var figureGenerator: FigureGenerator = $FigureGenerator

func handle_calls_updated() -> void:
    figureGenerator.use_next_figure()
