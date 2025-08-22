extends Node2D

@export var body: CharacterBody2D

var rotation_mode: int = 0
var is_moving: bool = false
var target_position: Vector2
var move_speed: Vector2 = FieldConfig.cell_size * 6

func init(_figure: GameFigure) -> void:
	rotation_mode = 0
	is_moving = false

func _process(delta: float) -> void:
	if is_moving:
		_smooth_move_to_target(delta)

func get_rotation_mode() -> int:
	return rotation_mode

func move_down_figure(_figure: GameFigure, _node: Node2D) -> bool:
	if is_moving or body.is_on_floor():
		return false
	
	target_position = body.position + Vector2(0, FieldConfig.cell_size.y)
	is_moving = true
	return true

func move_figure_side(_figure: GameFigure, x_direction: int, _node: Node2D) -> bool:
	if is_moving or body.is_on_wall():
		return false
	
	target_position = body.position + Vector2(FieldConfig.cell_size.x * x_direction, 0)
	is_moving = true
	return true

func _smooth_move_to_target(delta: float) -> void:
	var distance = target_position.distance_to(body.position)
	
	if distance < 1.0:  # Close enough to target
		body.position = target_position
		is_moving = false
	else:
		var direction = (target_position - body.position).normalized()
		body.velocity = direction * move_speed
		body.move_and_slide()

func rotate_figure(_figure: GameFigure) -> bool:
	if is_moving:
		return false
	rotation_mode = (rotation_mode + 1) % 4
	return true
