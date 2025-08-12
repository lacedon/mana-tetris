extends Node

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes
const FigureNode = preload("res://src/components/figure/figure.gd")
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")
const ArrayHelpers = preload("res://src/helpers/array.gd")

signal cells_updated(cells_per_row: Array[int])

@export var figure_node_ref: FigureNode

var _cells_per_row: Array[int] = ArrayHelpers.createArrayInt(FieldConfig.field_size.y)
var _global_cell_index = 0

func _create_cell_instance(cell: GameCell, cell_node: CellNode, position_offset: Vector2) -> CellNode:
    var cell_instance: CellNode = CellScene.instantiate()
    var cell_position: Vector2 = position_offset + cell_node.position
    cell_instance.name = "Cell #" + str(_global_cell_index)
    cell_instance.set_cell_type(cell.cell_type)
    cell_instance.position = cell_position
    _global_cell_index += 1
    return cell_instance

func set_figure_cells(figure: GameFigure) -> void:
    var figure_position: Vector2 = figure_node_ref.position
    var figure_cells: Array[CellNode] = figure_node_ref.get_cells()
    var cell_count: int = figure.cells.size()
    var filled_rows: Array[int] = []

    for cell_index in range(cell_count):
        var cell: GameCell = figure.cells[cell_index]
        if !cell || cell.cell_type == CellTypes.EMPTY: continue

        var cell_instance: CellNode = _create_cell_instance(cell, figure_cells[cell_index], figure_position)
        add_child(cell_instance)

        var cell_row: int = round(cell_instance.position.y / FieldConfig.cell_size.y)
        _cells_per_row[cell_row] += 1
        if (_cells_per_row[cell_row] >= FieldConfig.field_size.x):
            filled_rows.append(cell_row)

    if filled_rows.size() > 0:
        handle_row_filled(filled_rows)

    emit_signal(cells_updated.get_name(), _cells_per_row)

func handle_row_filled(row_indexes: Array[int]) -> void:
    var previous_cells_per_row: Array[int] = _cells_per_row.duplicate()
    var rows_count: int = FieldConfig.field_size.y

    # TODO: Rewrite to work with rows having all the cells instead of the individual cells
    for cell in get_children():
        # TODO: Would be nice not to go through the children
        if !(cell is CellNode): continue

        var cell_row_index: int = cell.position.y / FieldConfig.cell_size.y
        for row_index in row_indexes:
            if cell_row_index == row_index:
                # TODO: Need to rewrite to work with an entity pool here
                cell.queue_free()
                _cells_per_row[row_index] = 0
            if cell_row_index < row_index: # 1 19
                cell.position.y += FieldConfig.cell_size.y
                _cells_per_row[row_index] = 0
                if row_index + 1 < rows_count:
                    _cells_per_row[row_index + 1] += previous_cells_per_row[row_index]
