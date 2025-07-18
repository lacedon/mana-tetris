extends Node

const FigureNode = preload("res://src/components/figure/figure.gd")

@export var figureNode: FigureNode

func _ready() -> void:
    self.connect(figureNode.figure_set.get_name(), _set_figure_cells)

func _exit_tree() -> void:
    self.disconnect(figureNode.figure_set.get_name(), _set_figure_cells)

func _set_figure_cells(figure: GameFigure) -> void:
    prints('Setting figure cells for: ', figure)
