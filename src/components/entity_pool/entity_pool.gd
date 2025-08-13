extends Node

enum IncreasingMode {
    ## Just add one entity when needed
    LINEAR,
    ## Add twice as many entities when needed
    FACTORIAL
}

@export var container: Node
@export var increasing_mode: IncreasingMode = IncreasingMode.FACTORIAL

var _create_entity: Callable
var _used_entities: Array[Node] = []
var _free_entities: Array[Node] = []

func _create_entity_amount(amount: int) -> void:
    var start_index = _used_entities.size() + _free_entities.size()

    for i in range(amount):
        var entity: Node = _create_entity.call(start_index + i)
        entity.hide()
        _free_entities.append(entity)
        container.add_child(entity)

func init(
    new_create_entity: Callable,
    start_entity_number: int = 10,
    new_increasing_mode: IncreasingMode = increasing_mode,
    new_container: Node = container
) -> void:
    container = new_container if new_container else self
    increasing_mode = new_increasing_mode
    _create_entity = new_create_entity
    _create_entity_amount(start_entity_number)

func get_free_entity() -> Node:
    if _free_entities.size() == 0:
        match increasing_mode:
            IncreasingMode.LINEAR:
                _create_entity_amount(1)
            IncreasingMode.FACTORIAL:
                _create_entity_amount(_used_entities.size() * 2)

    var entity = _free_entities.pop_back()
    _used_entities.append(entity)
    entity.show()
    return entity

func remove_entity(entity: Node) -> void:
    entity.hide()
    if _used_entities.has(entity):
        _used_entities.erase(entity)
        _free_entities.append(entity)

func get_used_entities() -> Array[Node]:
    return _used_entities
