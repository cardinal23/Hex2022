extends Line2D

var size = 400
var coordinates: Vector2

onready var bounds = $Bounds
onready var coordinatesLabel = $Bounds/CoordinatesLabel

var debug := true

func _init():
    width = 1.0
    default_color = Color(0.4,0.4,0.4)
    
func _ready():
    var center = Vector2(size, (sqrt(3) * size) / 2)
    bounds.rect_min_size = Vector2(size * 2, sqrt(3) * size)
    
    var coordinatesText = "%d,%d" % [coordinates.x, coordinates.y]
    coordinatesLabel.text = coordinatesText
    
    set_points(
        PoolVector2Array([
            corner(center, size, 0),
            corner(center, size, 1),
            corner(center, size, 2),
            corner(center, size, 3),
            corner(center, size, 4),
            corner(center, size, 5),
            corner(center, size, 0)
        ])
    )
    
    #bounds.editor_only = !debug
    coordinatesLabel.visible = debug
          
# From https://www.redblobgames.com/grids/hexagons/
func corner(center, size, i):
    var angleDeg = 60 * i
    var angleRad = PI / 180 * angleDeg
    return Vector2(
        center.x + size * cos(angleRad),
        center.y + size * sin(angleRad)
    )
