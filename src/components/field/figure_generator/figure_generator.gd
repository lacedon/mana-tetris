extends Node

const FigureScene = preload("res://src/components/figure/figure.tscn")
const FigureNode = preload("res://src/components/figure/figure.gd")

@export var figureList: GameFigureList
@export var figureNode: FigureNode

@onready var currentFigure: GameFigure = get_random_figure()
@onready var nextFigure: GameFigure = get_random_figure()

func get_random_figure() -> GameFigure:
    if figureList.figures.size() == 0:
        return null

    var randomIndex: int = randi() % figureList.figures.size()
    return figureList.figures[randomIndex]

func use_next_figure() -> void:
    currentFigure = nextFigure
    nextFigure = get_random_figure()

    respawn_figure()

func _get_field_top_center() -> Vector2:
    var figureOffsetX: int = floor(float(currentFigure.size.x) / 2) if currentFigure else 0
    return Vector2(floor(FieldConfig.fieldSize.x / 2) - figureOffsetX, 0) * FieldConfig.cellSize

func respawn_figure() -> void:
    if !currentFigure: return

    figureNode.position = _get_field_top_center()
    figureNode.set_figure(currentFigure)

func _ready() -> void:
    if !currentFigure: return

    respawn_figure()
