extends Node

const FigureNode = preload("res://src/components/figure/figure.gd")

@export var figureNode: FigureNode
@export var movingWaitTime: float = 1.0
@export var movingWaitTimeFast: float = 0.1
@export var isPaused: bool = false

@onready var timer: Timer = $Timer

var isFastMoving: bool = false

func _ready() -> void:
    set_up_timer()

func _on_timer_timeout() -> void:
    if figureNode && !isPaused:
        figureNode.move_down_figure()

func set_up_timer(wait_time: float = movingWaitTime) -> void:
    timer.wait_time = wait_time
    timer.start()

func rotate_figure() -> void:
    if figureNode:
        figureNode.rotate_figure()

func toggle_figure_dropping(isFastMovingEnabled) -> void:
    isFastMoving = isFastMovingEnabled
    set_up_timer(movingWaitTimeFast if isFastMoving else movingWaitTime)

func move_figure(direction: int) -> void:
    if figureNode:
        figureNode.move_figure_side(direction)

func toggle_pause() -> void:
    isPaused = !isPaused
