static func get_min_value(array: Array[int]) -> int:
    var min_value: int = array[0]
    for value in array:
        if value < min_value:
            min_value = value
    return min_value

static func get_max_value(array: Array[int]) -> int:
    var max_value: int = array[0]
    for value in array:
        if value > max_value:
            max_value = value
    return max_value
