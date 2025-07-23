extends Node

const FigureMoverNode = preload("res://src/components/field/figure_mover/figure_mover.gd")

@export var figureMover: FigureMoverNode

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("rotate"):
        figureMover.rotate_figure()
    elif event.is_action_pressed("drop"):
        figureMover.toggle_figure_dropping(true)
    elif event.is_action_released("drop"):
        figureMover.toggle_figure_dropping(false)
    elif event.is_action_pressed("move-left"):
        figureMover.move_figure(-1)
    elif event.is_action_pressed("move-right"):
        figureMover.move_figure(1)
