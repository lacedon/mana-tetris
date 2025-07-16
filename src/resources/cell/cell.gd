extends Resource
class_name GameCell

const CELL_TYPES = preload("res://src/types/cell_types.gd").cellTypes

@export var cellType: CELL_TYPES = CELL_TYPES.EMPTY
