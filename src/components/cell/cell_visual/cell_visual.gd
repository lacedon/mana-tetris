extends Polygon2D

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes

var current_size: Vector2 = Vector2.ZERO

func init(cell_type: CellTypes, size: Vector2 = current_size) -> void:
    _set_cell_type(cell_type)
    _set_size(size)

func _set_size(size: Vector2) -> void:
    if current_size == size: return

    current_size = size
    var corners: PackedVector2Array = [
        Vector2.ZERO,
        Vector2(0, size.y),
        Vector2(size.x, size.y),
        Vector2(size.x, 0)
    ]
    self.polygon = corners

func _set_color_by_type(cell_type: CellTypes) -> void:
    match cell_type:
        CellTypes.BASE:
            self.color = Color(0.5, 0.5, 0.5)
        CellTypes.RANDOM:
            self.color = Color(1, 0, 1)
        CellTypes.HEAL:
            self.color = Color(0, 1, 0)
        CellTypes.ATTACK:
            self.color = Color(1, 0, 0)
        CellTypes.MANA_HEAL:
            self.color = Color(0, 0, 1)
        CellTypes.MANA_USAGE:
            self.color = Color(1, 1, 0)
        _:
            self.color = Color(1, 1, 1) # Default color for unknown types

func _set_cell_type(cell_type: CellTypes) -> void:
    _set_color_by_type(cell_type)
