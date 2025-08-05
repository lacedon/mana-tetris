extends Node

const NONE_COLLISION = 0
const CELL_COLLISION = 1

var areaList: Array[Area2D] = []
var cellCounterLabels: Array[Label] = []

func _ready() -> void:
    _create_area_list()
    _create_debug_numers()

func _exit_tree() -> void:
    for area2D in areaList:
        area2D.disconnect(area2D.area_entered.get_name(), _handle_cell_intersection)

func _create_debug_numers() -> void:
    for i in range(0, FieldConfig.fieldSize.y):
        var rowIndexLabel: Label = Label.new()
        rowIndexLabel.name = "RowIndex#" + str(i)
        rowIndexLabel.text = "#" + (str(i + 1) if i > 8 else '0' + str(i + 1))
        rowIndexLabel.position = Vector2(-0.5, i + 0.5) * FieldConfig.cellSize

        var cellCounterLabel: Label = Label.new()
        cellCounterLabel.name = "CellCounter#" + str(i)
        cellCounterLabel.text = "0"
        cellCounterLabel.position = Vector2(FieldConfig.fieldSize.x + 0.5, i + 0.5) * FieldConfig.cellSize
        cellCounterLabels.append(cellCounterLabel)

        add_child(rowIndexLabel)
        add_child(cellCounterLabel)

func _show_debug_info(cellNumberList: Array[int]) -> void:
    for index in range(cellNumberList.size()):
        cellCounterLabels[index].text = str(cellNumberList[index])

func _create_area_list() -> void:
    for i in range(0, FieldConfig.fieldSize.y):
        var rectangle: RectangleShape2D = RectangleShape2D.new()
        rectangle.size = Vector2(FieldConfig.fieldSize.x - 0.5, 0.5) * FieldConfig.cellSize

        var collisionShape: CollisionShape2D = CollisionShape2D.new()
        collisionShape.shape = rectangle
        collisionShape.position = rectangle.size / 2 + Vector2(0.25, 0.25) * FieldConfig.cellSize

        var area2D: Area2D = Area2D.new()
        area2D.name = "AreaRow#" + str(i)
        area2D.position = Vector2(0, i) * FieldConfig.cellSize
        area2D.add_child(collisionShape)
        area2D.collision_layer = NONE_COLLISION
        area2D.collision_mask = CELL_COLLISION

        area2D.connect(area2D.area_entered.get_name(), _handle_cell_intersection)

        add_child(area2D)
        areaList.append(area2D)

func _get_area_collision_fillment() -> Array[int]:
    var fullRowCellCount: int = FieldConfig.fieldSize.x
    var cellNumberList: Array[int] = []
    for areaIndex in range(areaList.size()):
        var area: Area2D = areaList[areaIndex]
        var size: int = area.get_overlapping_areas().size()
        cellNumberList.append(size)

    return cellNumberList

func _get_filled_rows(cellNumberList: Array[int]) -> Array[int]:
    var result: Array[int] = []
    var fullRowCellCount: int = FieldConfig.fieldSize.x
    for rowIndex in range(cellNumberList.size()):
        if cellNumberList[rowIndex] === fullRowCellCount:
            result.append(rowIndex)
    return result

func _handle_cell_intersection(_area2D: Area2D) -> void:
    var cellNumberList: Array[int] = _get_area_collision_fillment()
    _show_debug_info(cellNumberList)

    var filledRows: Array[int] = _get_filled_rows(cellNumberList)
