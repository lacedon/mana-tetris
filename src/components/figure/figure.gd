extends Node2D

const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

@export var figure: GameFigure

@onready var rayCast2D: RayCast2D = $RayCast2D

var cells: Array[CellNode] = []
var rotationMode: int = 0

func _add_missing_cells(figureArea: int = figure.get_area()) -> void:
    var cellCount = cells.size()
    if cellCount < figureArea:
        for index in range(cellCount, figureArea):
            var cellInstance: CellNode = CellScene.instantiate() as CellNode
            cellInstance.name = "Cell#" + str(index)
            cellInstance.hide()
            cells.append(cellInstance)
            add_child(cellInstance)

func _get_cell_position(index: int, figureSize: Vector2) -> Vector2:
    var x: int = index % int(figureSize.x)
    var y: int = floor(index / figureSize.x)
    if rotationMode == 1: # 90 degrees
        return Vector2(y, figureSize.x - 1 - x)
    elif rotationMode == 2: # 180 degrees
        return Vector2(figureSize.x - 1 - x, figureSize.y - 1 - y)
    elif rotationMode == 3: # 270 degrees
        return Vector2(figureSize.y - 1 - y, x)
    else: # 0 degrees
        return Vector2(x, y)

func _set_up_figure_cells(figureArea: int = figure.get_area()) -> void:
    for index in range(figureArea):
        var cellType: GameCell.CELL_TYPES = figure.get_cell_type(index)
        var cell: CellNode = cells[index]
        if cellType == GameCell.CELL_TYPES.EMPTY:
            cell.hide()
        else:
            cell.show()
            cell.set_cell_type(cellType)
            cell.position = _get_cell_position(index, figure.size) * FieldConfig.cellSize

func _hide_unused_cells(figureArea: int = figure.get_area()) -> void:
    for index in range(figureArea, cells.size()):
        cells[index].hide()

func set_figure(newFigure: GameFigure) -> void:
    rotationMode = 0

    figure = newFigure
    var figureArea = figure.get_area()

    _add_missing_cells(figureArea)
    _set_up_figure_cells(figureArea)
    _hide_unused_cells(figureArea)

    _define_ray_cast_2d()

func move_down_figure() -> void:
    if _can_move_down():
        self.position.y += FieldConfig.cellSize.y

func move_figure_side(xDirection: int) -> void:
    if _can_move_side(xDirection):
        self.position.x += xDirection * FieldConfig.cellSize.x

func rotate_figure() -> void:
    rotationMode = (rotationMode + 1) % 4
    _set_up_figure_cells(figure.get_area())
    pass

func _define_ray_cast_2d() -> void:
    if !rayCast2D || !figure: return
    rayCast2D.position = Vector2(float(figure.size.x) / 2, 0) * FieldConfig.cellSize

func _can_move_side(xDirection: int) -> bool:
    return _can_move_to(Vector2(xDirection * (float(figure.size.x) / 2) * FieldConfig.cellSize.x, 0))

func _can_move_down() -> bool:
    return _can_move_to(Vector2(0, (figure.size.y) * FieldConfig.cellSize.y))

func _can_move_to(target: Vector2) -> bool:
    if !rayCast2D: return false
    rayCast2D.target_position = target
    rayCast2D.force_raycast_update()
    return !rayCast2D.is_colliding()

func _ready() -> void:
    _define_ray_cast_2d()
