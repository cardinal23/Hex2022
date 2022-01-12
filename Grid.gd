extends Control

var Hex = preload("res://Hex.tscn")

var hexes = {}

var hexSize = 160
var gridSize = Vector2(5,5)

var highlightedHex: Vector2

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
            hex.axialCoordinates = oddq_to_axial(coordinates)
            hexes[coordinates] = hex
            
func _input(event):
    if event is InputEventMouseMotion:
        var eventCoordinates = pixel_to_flat_hex(event.position)
        highlightHex(eventCoordinates)
        print(eventCoordinates)
        
func highlightHex(coordinates):
    if !hexes.has(coordinates) || coordinates == highlightedHex:
        return 
     
    if highlightedHex != null:
        var hex = hexes[highlightedHex]
        hex.isHighlighted = false
        hex.update()
           
    var hex = hexes[coordinates]
    highlightedHex = coordinates
    hex.isHighlighted = true
    hex.update()
        
# Hex grid functions

# https://www.redblobgames.com/grids/hexagons/#coordinates-axial
func pixel_to_flat_hex(point):
    var q = ( float(2)/3 * point.x                        ) / hexSize
    var r = (float(-1)/3 * point.x  +  sqrt(3)/3 * point.y) / hexSize
    return axial_to_oddq(axial_round(Vector2(q, r)))

func oddq_to_axial(coordinates):
    var q = coordinates.x
    var r = coordinates.y - (coordinates.x - (int(coordinates.x)&1)) / 2
    return Vector2(q, r)
    
func axial_to_oddq(axialCoordinates):
    var q = axialCoordinates.x
    var r = axialCoordinates.y
    
    var x = q
    var y = r + (q - (int(q)&1)) / 2
    
    return Vector2(x,y)
    
func cube_round(frac):
    var q = round(frac.x)
    var r = round(frac.y)
    var s = round(frac.z)

    var q_diff = abs(q - frac.x)
    var r_diff = abs(r - frac.y)
    var s_diff = abs(s - frac.z)

    if q_diff > r_diff and q_diff > s_diff:
        q = -r-s
    elif r_diff > s_diff:
        r = -q-s
    else:
        s = -q-r

    return Vector3(q, r, s)
    
func axial_round(hex):
    return cube_to_axial(cube_round(axial_to_cube(hex)))

func cube_to_axial(cube):
    var q = cube.x
    var r = cube.y
    return Vector2(q, r)

func axial_to_cube(hex):
    var q = hex.x
    var r = hex.y
    var s = -q-r
    return Vector3(q, r, s)
