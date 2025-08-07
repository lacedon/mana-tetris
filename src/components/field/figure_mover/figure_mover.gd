extends Node

const FigureNode = preload("res://src/components/figure/figure.gd")

@export var figure_node_ref: FigureNode
@export var moving_wait_time: float = 1.0
@export var moving_wait_time_fast: float = 0.1
@export var is_paused: bool = false

@onready var timer_ref: Timer = $Timer

var is_fast_moving: bool = false

func _ready() -> void:
    set_up_timer()

func _on_timer_timeout() -> void:
    if figure_node_ref && !is_paused:
        figure_node_ref.move_down_figure()

func set_up_timer(wait_time: float = moving_wait_time) -> void:
    timer_ref.wait_time = wait_time
    timer_ref.start()

func rotate_figure() -> void:
    if figure_node_ref:
        figure_node_ref.rotate_figure()

func toggle_figure_dropping(is_fast_moving_enabled) -> void:
    is_fast_moving = is_fast_moving_enabled
    set_up_timer(moving_wait_time_fast if is_fast_moving else moving_wait_time)

func move_figure(direction: int) -> void:
    if figure_node_ref:
        figure_node_ref.move_figure_side(direction)

func toggle_pause() -> void:
    is_paused = !is_paused
