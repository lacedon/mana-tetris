extends Node

const FigureNode = preload("res://src/components/figure/figure.gd")

@export var figureNode: FigureNode
@export var speed: float = 1.0
@export var isPaused: bool = false

@onready var timer: Timer = $Timer

func set_figure_node(newFigureNode: FigureNode) -> void:
    self.figureNode = newFigureNode

    timer.start()

func _on_timer_timeout() -> void:
    if figureNode:
        figureNode.move_down_figure()

func rotate_figure() -> void:
    if figureNode:
        figureNode.rotate_figure()
