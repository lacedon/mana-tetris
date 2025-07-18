extends Node

const FigureNode = preload("res://src/components/figure/figure.gd")

@export var figureNode: FigureNode
@export var speed: float = 1.0
@export var isPaused: bool = false

@onready var timer: Timer = $Timer

func _ready() -> void:
    timer.start()

func _on_timer_timeout() -> void:
    if figureNode && !isPaused:
        figureNode.move_down_figure()

func rotate_figure() -> void:
    if figureNode:
        figureNode.rotate_figure()

func drop_figure() -> void:
    if figureNode:
        # TODO: Implement drop logic
        pass

func move_figure(direction: int) -> void:
    if figureNode:
        figureNode.move_figure_side(direction)