extends Resource
class_name GameCell

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes

@export var cell_type: CellTypes = CellTypes.EMPTY
