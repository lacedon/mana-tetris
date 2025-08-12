extends Node

var cell_counter_labels: Array[Label] = []

func _ready() -> void:
    _create_debug_numbers()

func _create_debug_numbers() -> void:
    for i in range(0, FieldConfig.field_size.y):
        var row_index_label: Label = Label.new()
        row_index_label.name = "RowIndex#" + str(i)
        row_index_label.text = "#" + (str(i + 1) if i > 8 else '0' + str(i + 1))
        row_index_label.size = FieldConfig.cell_size
        row_index_label.position = Vector2(-1, i) * FieldConfig.cell_size

        var cell_counter_label: Label = Label.new()
        cell_counter_label.name = "CellCounter#" + str(i)
        cell_counter_label.text = "0"
        cell_counter_label.position = Vector2(FieldConfig.field_size.x, i) * FieldConfig.cell_size
        cell_counter_label.size = FieldConfig.cell_size
        cell_counter_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
        cell_counter_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
        cell_counter_labels.append(cell_counter_label)

        add_child(row_index_label)
        add_child(cell_counter_label)

func show_debug_info(cell_number_list: Array[int]) -> void:
    var cell_number_list_size = cell_number_list.size()
    for index in range(cell_counter_labels.size()):
        cell_counter_labels[index].text = str(cell_number_list[index]) if index < cell_number_list_size else "0"
