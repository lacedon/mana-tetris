extends Node2D

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
@export var render_mode: CellRenderMode = CellRenderMode.STATIC

@onready var cell_visual: CellVisual = $CellVisual

var collision: CollisionObject2D

func _ready() -> void:
    _prepare_collision()
    set_cell_type()
    emit_signal(cell_ready.get_name())
    cell_visual.init(cell_type, FieldConfig.cell_size)

func set_cell_type(new_type: CellTypes = cell_type) -> void:
    cell_type = new_type
    visible = cell_type != CellTypes.EMPTY
    if (cell_visual): cell_visual.init(new_type)

func set_render_mode(new_mode: CellRenderMode) -> void:
    render_mode = new_mode
    _prepare_collision()

func _prepare_collision() -> void:
    if collision: collision.queue_free()

    if render_mode == CellRenderMode.STATIC:
        var staticCollision: CellCollisionStatic = CellCollisionStaticScene.instantiate() as CellCollisionStatic
        add_child(staticCollision)
        collision = staticCollision
