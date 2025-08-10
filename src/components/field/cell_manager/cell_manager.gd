extends Node

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes
const FigureNode = preload("res://src/components/figure/figure.gd")
const CellScene = preload("res://src/components/cell/cell.tscn")
const CellNode = preload("res://src/components/cell/cell.gd")

signal cells_updated

@export var figure_node_ref: FigureNode

func _handle_last_cell_ready() -> void:
    emit_signal(cells_updated.get_name())

func set_figure_cells(figure: GameFigure) -> void:
    var figure_position: Vector2 = figure_node_ref.position
    var figure_cells: Array[CellNode] = figure_node_ref.get_cells()
    var cell_count: int = figure.cells.size()
    for cell_index in range(cell_count):
        var cell: GameCell = figure.cells[cell_index]
        var is_last_cell: bool = cell_index == (cell_count - 1)

        if !cell || cell.cell_type == CellTypes.EMPTY:
            continue

        var cell_instance: CellNode = CellScene.instantiate()
        if is_last_cell:
            cell_instance.connect(cell_instance.cell_ready.get_name(), _handle_last_cell_ready, CONNECT_ONE_SHOT)

        var cell_position: Vector2 = figure_position + figure_cells[cell_index].position
        var cell_position_in_field: Vector2 = cell_position / FieldConfig.cell_size
        cell_instance.name = "Cell" + str(cell_position_in_field)
        cell_instance.set_cell_type(cell.cell_type)
        cell_instance.position = cell_position
        add_child(cell_instance)

func handle_row_filled(row_indexes: Array[int]) -> void:
    prints('handle_row_filled', row_indexes)

    # TODO: Would be nice not to go through the children
    for cell in get_children():
        if !(cell is CellNode): continue

        var cell_row_index: int = cell.position.y / FieldConfig.cell_size.y
        for row_index in row_indexes:
            if row_index == cell_row_index:
                # TODO: Need an entity pool here
                cell.hide()
            if row_index > cell_row_index:
                cell.position.y += FieldConfig.cell_size.y            

    emit_signal(cells_updated.get_name())
