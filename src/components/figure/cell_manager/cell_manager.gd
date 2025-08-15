extends Node

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")
const EntityPool = preload("res://src/components/entity_pool/entity_pool.gd")

@export var default_figure_area: int = 2

@onready var entity_pool: EntityPool = $EntityPool
@onready var cell_container: Node = $Cells

func _ready() -> void:
    entity_pool.init(
        _create_cell,
        default_figure_area,
        EntityPool.IncreasingMode.FACTORIAL,
        cell_container
    )

func _create_cell(index: int) -> CellNode:
    var cell_instance: CellNode = CellScene.instantiate() as CellNode
    cell_instance.name = "Cell#" + str(index)
    cell_instance.set_render_mode(CellNode.CellRenderMode.VISUAL_ONLY)
    return cell_instance

func _get_cell_position(rotation_mode: int, index: int, figure_size: Vector2) -> Vector2:
    var x: int = index % int(figure_size.x)
    var y: int = floor(index / figure_size.x)
    if rotation_mode == 1: # 90 degrees
        return Vector2(y, figure_size.x - 1 - x)
    elif rotation_mode == 2: # 180 degrees
        return Vector2(figure_size.x - 1 - x, figure_size.y - 1 - y)
    elif rotation_mode == 3: # 270 degrees
        return Vector2(figure_size.y - 1 - y, x)
    else: # 0 degrees
        return Vector2(x, y)

func set_up_cells(rotation_mode: int, figure: GameFigure) -> void:
    var figure_area: int = figure.get_area()

    for index in range(figure_area):
        var cell: CellNode = entity_pool.get_cell_by_index(index, true)
        var cell_type: CellTypes = figure.get_cell_type(index)
        cell.set_cell_type(cell_type)
        cell.position = _get_cell_position(rotation_mode, index, figure.size) * FieldConfig.cell_size

    # Remove unused cells
    for index in range(entity_pool.get_used_entities_count() - 1, figure_area - 1, -1):
        entity_pool.remove_entity_by_index(index)

func get_cells() -> Array[CellNode]:
    var cells: Array[CellNode]
    cells.assign(entity_pool.get_used_entities())
    return cells
