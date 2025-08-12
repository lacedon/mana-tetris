static func createArray(size: int, default_value: Variant = null) -> Array:
    var arr: Array = []
    for i in range(size):
        arr.append(default_value)
    return arr

static func createArrayInt(size: int, default_value: Variant = 0) -> Array[int]:
    var arr: Array[int] = []
    for i in range(size):
        arr.append(default_value)
    return arr
