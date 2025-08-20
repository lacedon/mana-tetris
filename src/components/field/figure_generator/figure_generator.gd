extends Node

const FigureNode = preload("res://src/components/figure/figure.gd")

@export var figure_list: GameFigureList
@export var figure_node_ref: FigureNode

@onready var current_figure: GameFigure = get_random_figure()
@onready var next_figure: GameFigure = get_random_figure()

func get_random_figure() -> GameFigure:
	if figure_list.figures.size() == 0:
		return null

	var random_index: int = randi() % figure_list.figures.size()
	return figure_list.figures[random_index]

func use_next_figure() -> void:
	current_figure = next_figure
	next_figure = get_random_figure()

	respawn_figure()

func _get_field_top_center() -> Vector2:
	var figure_offset_x: int = floor(float(current_figure.size.x) / 2) if current_figure else 0
	return Vector2(floor(FieldConfig.field_size.x / 2) - figure_offset_x, 0) * FieldConfig.cell_size

func respawn_figure() -> void:
	if !current_figure: return

	figure_node_ref.set_figure(current_figure, _get_field_top_center())

func _ready() -> void:
	if !current_figure: return

	respawn_figure()
