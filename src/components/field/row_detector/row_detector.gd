extends Node

const NONE_COLLISION = 0
const CELL_COLLISION = 1

var areaList: Array[Area2D] = []

func _ready() -> void:
    _create_area_list()

func _create_area_list() -> void:
    for i in range(0, FieldConfig.fieldSize.y):
        var rectangle: RectangleShape2D = RectangleShape2D.new()
        rectangle.size = Vector2(FieldConfig.fieldSize.x, 1) * FieldConfig.cellSize

        var collisionShape: CollisionShape2D = CollisionShape2D.new()
        collisionShape.shape = rectangle
        collisionShape.position = rectangle.size / 2

        var area2D: Area2D = Area2D.new()
        area2D.name = "AreaRow#" + str(i)
        area2D.position = Vector2(0, i) * FieldConfig.cellSize
        area2D.add_child(collisionShape)
        area2D.collision_layer = NONE_COLLISION
        area2D.collision_mask = CELL_COLLISION

        add_child(area2D)
        areaList.append(area2D)

func _get_area_collision_fillment() -> Array[int]:
    var fullRowCellCount: int = FieldConfig.fieldSize.x
    var isFilledByAreaList: Array[int] = []
    for area in areaList:
        var size: int = area.get_overlapping_areas().size()
        # prints(area.name + " has " + str(size) + " cells", area.get_overlapping_areas())
        isFilledByAreaList.append(size)

    return isFilledByAreaList

func check_row_fulfillment() -> void:
    prints(_get_area_collision_fillment())
