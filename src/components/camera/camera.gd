extends Camera2D

func _ready() -> void:
    self.offset = -FieldConfig.cell_size * Vector2(1, 0)
