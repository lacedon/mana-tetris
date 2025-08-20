extends CollisionShape2D

const CellTypes = preload("res://src/types/cell_types.gd").CellTypes
const CellVisual = preload("res://src/components/cell/cell_visual/cell_visual.gd")
const CellCollisionStatic = preload("res://src/components/cell/cell_collision_static/cell_collision_static.gd")
const CellCollisionStaticScene = preload("res://src/components/cell/cell_collision_static/cell_collision_static.tscn")

enum CellRenderMode {
	STATIC,
	VISUAL_ONLY,
}

signal cell_ready

@export var cell_type: CellTypes = CellTypes.EMPTY

@onready var cell_visual: CellVisual = $CellVisual
@onready var collision: CollisionShape2D = self

func _ready() -> void:
	_prepare_collision()
	set_cell_type()
	emit_signal(cell_ready.get_name())
	cell_visual.init(cell_type, FieldConfig.cell_size)

func set_cell_type(new_type: CellTypes = cell_type) -> void:
	cell_type = new_type
	visible = cell_type != CellTypes.EMPTY
	if (cell_visual): cell_visual.init(new_type)

func _prepare_collision() -> void:
	var collision_shape: ConvexPolygonShape2D = collision.shape
	collision_shape.points = [
		Vector2.ZERO,
		Vector2(0, FieldConfig.cell_size.y),
		Vector2(FieldConfig.cell_size.x, FieldConfig.cell_size.y),
		Vector2(FieldConfig.cell_size.x, 0),
	]
