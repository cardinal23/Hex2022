extends Control

var Hex = preload("res://Hex.tscn")

var hexes = {}

func _init():
    var size = 80
    
    for y in 5:
        for x in 5:
            var hex = Hex.instance()
            hex.size = size
            hex.position = Vector2(
                100 * x + size,
                100 * y + sqrt(3) * size
            )
            add_child(hex)
    
# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.
