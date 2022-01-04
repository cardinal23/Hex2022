extends Control

var Hex = preload("res://Hex.tscn")

var hexes = {}

func _init():
    var size = 80
    var width = 2 * size
    var height = sqrt(3) * size
    
    for y in 5:
        for x in 5:
            var oddOffset = x % 2 * (height / 2)
            
            var hex = Hex.instance()
            hex.size = size
            hex.position = Vector2(
                (width * 0.75) * x,
                height * y + oddOffset
            )
            add_child(hex)
