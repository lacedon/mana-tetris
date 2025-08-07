extends Node

@onready var ray_cast_2d: RayCast2D = $RayCast2D

var rotation_mode: int = 0

func _define_ray_cast_2d(figure: GameFigure) -> void:
    if !ray_cast_2d || !figure: return
    ray_cast_2d.position = Vector2(float(figure.size.x) / 2, 0) * FieldConfig.cell_size

func _can_move_to(target: Vector2) -> bool:
    if !ray_cast_2d: return false
    ray_cast_2d.target_position = target
    ray_cast_2d.force_raycast_update()
    return !ray_cast_2d.is_colliding()

func _can_move_side(figure: GameFigure, x_direction: int) -> bool:
    return _can_move_to(Vector2(x_direction * (float(figure.size.x) / 2) * FieldConfig.cell_size.x, 0))

func _can_move_down(figure: GameFigure) -> bool:
    return _can_move_to(Vector2(0, (figure.size.y) * FieldConfig.cell_size.y))

func init(figure: GameFigure) -> void:
    rotation_mode = 0
    _define_ray_cast_2d(figure)

func get_rotation_mode() -> int:
    return rotation_mode

func move_down_figure(figure: GameFigure, node: Node2D) -> bool:
    if _can_move_down(figure):
        node.position.y += FieldConfig.cell_size.y
        return true
    else:
        return false

func move_figure_side(figure: GameFigure, x_direction: int, node: Node2D) -> bool:
    if _can_move_side(figure, x_direction):
        node.position.x += x_direction * FieldConfig.cell_size.x
        return true
    return false

func rotate_figure(_figure: GameFigure) -> bool:
    rotation_mode = (rotation_mode + 1) % 4
    return true
