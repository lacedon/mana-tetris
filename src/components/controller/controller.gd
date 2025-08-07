extends Node

const FigureMoverNode = preload("res://src/components/field/figure_mover/figure_mover.gd")

@export var figure_mover_ref: FigureMoverNode

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("rotate"):
        figure_mover_ref.rotate_figure()
    elif event.is_action_pressed("drop"):
        figure_mover_ref.toggle_figure_dropping(true)
    elif event.is_action_released("drop"):
        figure_mover_ref.toggle_figure_dropping(false)
    elif event.is_action_pressed("move-left"):
        figure_mover_ref.move_figure(-1)
    elif event.is_action_pressed("move-right"):
        figure_mover_ref.move_figure(1)
    elif event.is_action_pressed("pause"):
        figure_mover_ref.toggle_pause()
