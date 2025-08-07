extends Node

signal filled_rows_detected(filled_rows: Array[int])

const Collisions = preload("res://src/common/collisions.gd").Collisions

var area_list: Array[Area2D] = []
var cell_counter_labels: Array[Label] = []

func _ready() -> void:
    _create_area_list()
    _create_debug_numbers()

func _exit_tree() -> void:
    for area_2d in area_list:
        area_2d.disconnect(area_2d.area_entered.get_name(), _handle_cell_intersection)

func _create_debug_numbers() -> void:
    for i in range(0, FieldConfig.field_size.y):
        var row_index_label: Label = Label.new()
        row_index_label.name = "RowIndex#" + str(i)
        row_index_label.text = "#" + (str(i + 1) if i > 8 else '0' + str(i + 1))
        row_index_label.position = Vector2(-0.5, i + 0.5) * FieldConfig.cell_size

        var cell_counter_label: Label = Label.new()
        cell_counter_label.name = "CellCounter#" + str(i)
        cell_counter_label.text = "0"
        cell_counter_label.position = Vector2(FieldConfig.field_size.x + 0.5, i + 0.5) * FieldConfig.cell_size
        cell_counter_labels.append(cell_counter_label)

        add_child(row_index_label)
        add_child(cell_counter_label)

func _show_debug_info(cell_number_list: Array[int]) -> void:
    for index in range(cell_number_list.size()):
        cell_counter_labels[index].text = str(cell_number_list[index])

func _create_area_list() -> void:
    for i in range(0, FieldConfig.field_size.y):
        var rectangle: RectangleShape2D = RectangleShape2D.new()
        rectangle.size = Vector2(FieldConfig.field_size.x - 0.5, 0.5) * FieldConfig.cell_size

        var collision_shape: CollisionShape2D = CollisionShape2D.new()
        collision_shape.shape = rectangle
        collision_shape.position = rectangle.size / 2 + Vector2(0.25, 0.25) * FieldConfig.cell_size

        var area_2d: Area2D = Area2D.new()
        area_2d.name = "AreaRow#" + str(i)
        area_2d.position = Vector2(0, i) * FieldConfig.cell_size
        area_2d.add_child(collision_shape)
        area_2d.collision_layer = Collisions.NONE
        area_2d.collision_mask = Collisions.CELL

        area_2d.connect(area_2d.area_entered.get_name(), _handle_cell_intersection)

        add_child(area_2d)
        area_list.append(area_2d)

func _get_area_collision_fillment() -> Array[int]:
    var cell_number_list: Array[int] = []
    for area_index in range(area_list.size()):
        var area: Area2D = area_list[area_index]
        var size: int = area.get_overlapping_areas().size()
        cell_number_list.append(size)

    return cell_number_list

func _get_filled_rows(cell_number_list: Array[int]) -> Array[int]:
    var result: Array[int] = []
    var full_row_cell_count: int = int(FieldConfig.field_size.x)
    for row_index in range(cell_number_list.size()):
        if cell_number_list[row_index] == full_row_cell_count:
            result.append(row_index)
    return result

func _handle_cell_intersection(_area_2d: Area2D) -> void:
    var cell_number_list: Array[int] = _get_area_collision_fillment()
    _show_debug_info(cell_number_list)

    var filled_rows: Array[int] = _get_filled_rows(cell_number_list)
    if filled_rows.size() > 0:
        emit_signal(filled_rows_detected.get_name(), filled_rows)
