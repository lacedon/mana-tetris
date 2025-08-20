extends Node2D

const CellNode = preload("res://src/components/cell/cell.gd")
const CellManager = preload("res://src/components/figure/cell_manager/cell_manager.gd")
const MoveManager = preload("res://src/components/figure/move_manager/move_manager.gd")

signal figure_set(figure: GameFigure)

@export var figure: GameFigure

@onready var cell_manager_ref: CellManager = $CellManager
@onready var move_manager_ref: MoveManager = $MoveManager
@onready var body: CharacterBody2D = $Body

var _initial_body_position: Vector2 = Vector2.ZERO

func _ready() -> void:
    move_manager_ref.init(figure)
    cell_manager_ref.set_up_cells(move_manager_ref.get_rotation_mode(), figure)
    body.position = _initial_body_position

func set_figure(new_figure: GameFigure, body_position: Vector2) -> void:
    figure = new_figure

    if move_manager_ref: move_manager_ref.init(figure)
    if cell_manager_ref: cell_manager_ref.set_up_cells(move_manager_ref.get_rotation_mode(), figure)

    if body: body.position = body_position
    else: _initial_body_position = body_position

func move_down_figure() -> void:
    var has_moved: bool = move_manager_ref.move_down_figure(figure, body)
    if !has_moved: emit_signal("figure_set", figure)

func move_figure_side(x_direction: int) -> void:
    move_manager_ref.move_figure_side(figure, x_direction, body)

func rotate_figure() -> void:
    var has_rotated: bool = move_manager_ref.rotate_figure(figure)
    if has_rotated: cell_manager_ref.set_up_cells(move_manager_ref.get_rotation_mode(), figure)

func get_cells() -> Array[CellNode]:
    return cell_manager_ref.get_cells()

func get_body_position() -> Vector2:
    return body.position
