extends Node

@onready var rayCast2D: RayCast2D = $RayCast2D

var rotationMode: int = 0

func _define_ray_cast_2d(figure: GameFigure) -> void:
    if !rayCast2D || !figure: return
    rayCast2D.position = Vector2(float(figure.size.x) / 2, 0) * FieldConfig.cellSize

func _can_move_to(target: Vector2) -> bool:
    if !rayCast2D: return false
    rayCast2D.target_position = target
    rayCast2D.force_raycast_update()
    return !rayCast2D.is_colliding()

func _can_move_side(figure: GameFigure, xDirection: int) -> bool:
    return _can_move_to(Vector2(xDirection * (float(figure.size.x) / 2) * FieldConfig.cellSize.x, 0))

func _can_move_down(figure: GameFigure) -> bool:
    return _can_move_to(Vector2(0, (figure.size.y) * FieldConfig.cellSize.y))

func init(figure: GameFigure, shouldResetMode: bool = false) -> void:
    if shouldResetMode: rotationMode = 0
    _define_ray_cast_2d(figure)

func getMoveRotationMode() -> int:
    return rotationMode

func move_down_figure(figure: GameFigure, node: Node2D) -> bool:
    if _can_move_down(figure):
        node.position.y += FieldConfig.cellSize.y
        return true
    else:
        return false

func move_figure_side(figure: GameFigure, xDirection: int, node: Node2D) -> bool:
    if _can_move_side(figure, xDirection):
        node.position.x += xDirection * FieldConfig.cellSize.x
        return true
    return false

func rotate_figure(_figure: GameFigure) -> bool:
    rotationMode = (rotationMode + 1) % 4
    return true
