extends Control

var Hex = preload("res://Hex.tscn")

var hexes = {}

func _init():
    var size = 80
    var width = 2 * size
    var height = sqrt(3) * size
    
    for y in 8:
        for x in 15:
            # Everything needed to be divided in half here and I don't know why :(
            var oddVerticalOffset = (x % 2) * (height / 2)
        
            var hex = Hex.instance()
            hex.size = size
            hex.position = Vector2(
                (width * 0.75) * x / 2,
                (height * y / 2) + oddVerticalOffset / 2
            )
            add_child(hex)
            var coordinates = Vector2(x,y)
            hex.coordinates = coordinates
            hexes[coordinates] = hex
            
func _input(event):
    if event is InputEventMouseMotion:
        print(event.position)
    
