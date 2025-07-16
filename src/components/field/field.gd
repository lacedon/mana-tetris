extends Node2D

const FigureGenerator = preload("res://src/components/field/figure_generator/figure_generator.gd")
const FigureMover = preload("res://src/components/field/figure_mover/figure_mover.gd")

@export var figureList: GameFigureList

@onready var figureGenerator: FigureGenerator = $FigureGenerator
@onready var figureMover: FigureMover = $FigureMover

var figureNode: Node2D = null

func regenerate_figure() -> void:
    figureGenerator.use_next_figure()

func _set_figure_node(newFigureNode: Node2D) -> void:
    figureNode = newFigureNode
    if is_node_ready():
        figureMover.set_figure_node(newFigureNode)

func _ready() -> void:
    figureMover.set_figure_node(figureNode)
