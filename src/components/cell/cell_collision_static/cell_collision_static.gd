extends CollisionObject2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var current_size: Vector2 = FieldConfig.cell_size

func _ready() -> void:
    _set_up_collision_shape(current_size)

func _set_up_collision_shape(new_size: Vector2) -> void:
    current_size = new_size

    collision_shape.shape.size = new_size
    collision_shape.position = new_size / 2
