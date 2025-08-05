static func getMinValue(array: Array[int]) -> int:
    var minValue: int = array[0]
    for value in array:
        if value < minValue:
            minValue = value
    return minValue

static func getMaxValue(array: Array[int]) -> int:
    var maxValue: int = array[0]
    for value in array:
        if value > maxValue:
            maxValue = value
    return maxValue
