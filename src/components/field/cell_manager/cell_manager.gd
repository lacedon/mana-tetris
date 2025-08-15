extends Node

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes
const FigureNode = preload("res://src/components/figure/figure.gd")
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")
const ArrayHelpers = preload("res://src/helpers/array.gd")
const EntityPool = preload("res://src/components/entity_pool/entity_pool.gd")

signal cells_updated(cells_per_row: Array[int])

@export var figure_node_ref: FigureNode
@export var cell_container: Node

@onready var entity_pool: EntityPool = $EntityPool

var _cells_per_row: Array[int] = ArrayHelpers.createArrayInt(int(FieldConfig.field_size.y))

func _ready() -> void:
    if !cell_container: cell_container = self

    entity_pool.init(
        _create_cell,
        int(FieldConfig.field_size.x * FieldConfig.field_size.y),
        EntityPool.IncreasingMode.LINEAR,
        cell_container
    )

func _create_cell(index: int) -> Node:
    var cell_instance: CellNode = CellScene.instantiate()
    cell_instance.name = "Cell #" + str(index)
    return cell_instance

func _create_cell_instance(cell: GameCell, cell_node: CellNode, offset: Vector2) -> CellNode:
    var cell_instance: CellNode = entity_pool.get_free_entity()
    var cell_position: Vector2 = offset + cell_node.position
    cell_instance.set_cell_type(cell.cell_type)
    cell_instance.position = cell_position
    return cell_instance

func _move_and_delete_row_nodes(filled_row_indexes: Array[int]) -> void:
    var used_entities: Array[Node] = entity_pool.get_used_entities()
    var index_offset: int = 0

    # TODO: Rewrite to work with rows having all the cells instead of the individual cells
    for cell_index in range(used_entities.size()):
        var cell: CellNode = used_entities[cell_index + index_offset]
        var cell_row_index: int = round(cell.position.y / FieldConfig.cell_size.y)
        for filled_row_index in filled_row_indexes:
            if cell_row_index == filled_row_index:
                entity_pool.remove_entity(cell)
                index_offset -= 1
            elif cell_row_index < filled_row_index:
                cell.position.y += FieldConfig.cell_size.y

func _sync_cells_per_row(filled_row_indexes: Array[int]) -> void:
    var rows_count: int = _cells_per_row.size()

    _cells_per_row[0] = 0
    for filled_row_index in filled_row_indexes:
        var previous_cells_per_row: Array[int] = _cells_per_row.duplicate()
        for row_index in range(1, rows_count):
            if row_index <= filled_row_index:
                _cells_per_row[row_index] = previous_cells_per_row[row_index - 1] if row_index > 0 else 0
            else:
                break

func _handle_row_filled(filled_row_indexes: Array[int]) -> void:
    _move_and_delete_row_nodes(filled_row_indexes)
    _sync_cells_per_row(filled_row_indexes)

func set_figure_cells(figure: GameFigure) -> void:
    var figure_position: Vector2 = figure_node_ref.position
    var figure_cells: Array[CellNode] = figure_node_ref.get_cells()
    var cell_count: int = figure.cells.size()
    var filled_rows: Array[int] = []

    for cell_index in range(cell_count):
        var cell: GameCell = figure.cells[cell_index]
        if !cell || cell.cell_type == CellTypes.EMPTY: continue

        var cell_instance: CellNode = _create_cell_instance(cell, figure_cells[cell_index], figure_position)

        var cell_row: int = round(cell_instance.position.y / FieldConfig.cell_size.y)
        _cells_per_row[cell_row] += 1
        if (_cells_per_row[cell_row] >= FieldConfig.field_size.x):
            filled_rows.append(cell_row)

    if filled_rows.size() > 0:
        _handle_row_filled(filled_rows)

    emit_signal(cells_updated.get_name(), _cells_per_row)
