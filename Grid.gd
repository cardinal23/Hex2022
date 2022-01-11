extends Control

var Hex = preload("res://Hex.tscn")

var hexes = {}

var hexSize = 160
var gridSize = Vector2(15,8)

func _init():
    var size = hexSize / 2
    var width = hexSize
    var height = sqrt(3) * size
    
    for y in gridSize.y:
        for x in gridSize.x:
            var oddVerticalOffset = (x&1) * (height)
        
            var hex = Hex.instance()
            hex.size = size
            hex.position = Vector2(
                (width * 0.75) * x,
                (height * y) + oddVerticalOffset / 2
            )
            add_child(hex)
            var coordinates = Vector2(x,y)
            hex.coordinates = coordinates
            hexes[coordinates] = hex
            
func _input(event):
    if event is InputEventMouseMotion:
        print(event.position)
        
# Hex grid functions

# https://www.redblobgames.com/grids/hexagons/#coordinates-axial
func oddqToAxial(coordinates):
    var q = coordinates.x
    var r = coordinates.y - (coordinates.y - (coordinates.y&1)) / 2
    return Vector2(q, r)
    
func axialToOddq(axialCoordinates):
    var q = axialCoordinates.x
    var r = axialCoordinates.y
    
    var x = q
    var y = r + (q - (q&1)) / 2
    
    return Vector2(x,y)
    
