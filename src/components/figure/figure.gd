extends Node2D

const CellNode = preload("res://src/components/cell/cell.gd")
const CellManager = preload("res://src/components/figure/cell_manager/cell_manager.gd")
const MoveManager = preload("res://src/components/figure/move_manager/move_manager.gd")

signal figure_set(figure: GameFigure)

@export var figure: GameFigure

@onready var cellManager: CellManager = $CellManager
@onready var moveManager: MoveManager = $MoveManager

func _ready() -> void:
    moveManager.init(figure)
    cellManager.set_up_cells(moveManager.get_rotation_mode(), figure)

func set_figure(newFigure: GameFigure) -> void:
    figure = newFigure

    if moveManager: moveManager.init(figure)
    if cellManager: cellManager.set_up_cells(moveManager.get_rotation_mode(), figure)

func move_down_figure() -> void:
    var hasMoved: bool = moveManager.move_down_figure(figure, self)
    if !hasMoved: emit_signal("figure_set", figure)

func move_figure_side(xDirection: int) -> void:
    moveManager.move_figure_side(figure, xDirection, self)

func rotate_figure() -> void:
    var hasRotated: bool = moveManager.rotate_figure(figure)
    if hasRotated: cellManager.set_up_cells(moveManager.get_rotation_mode(), figure)

func get_cells() -> Array[CellNode]:
    return cellManager.get_cells()
