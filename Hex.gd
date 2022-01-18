extends Line2D

var size = 400

var coordinates: Vector2
var axialCoordinates: Vector2

onready var bounds = $Bounds
onready var coordinatesLabel = $Bounds/CoordinatesLabel
onready var axialCoordinatesLabel = $Bounds/AxialCoordinatesLabel

var debug := false
var isHighlighted := false

func _init():
    width = 1.0
    default_color = Color(0.4,0.4,0.4)
    
func _ready():   
    var center = Vector2(size, (sqrt(3) * size) / 2)
    bounds.rect_min_size = Vector2(size * 2, sqrt(3) * size)
    
    var coordinatesText = "%d,%d" % [coordinates.x, coordinates.y]
    coordinatesLabel.text = coordinatesText
    coordinatesLabel.rect_position = Vector2(
        center.x - coordinatesLabel.rect_size.x / 2,
        center.y - coordinatesLabel.rect_size.y
    )
    var axialCoordinatesText = "%d,%d" % [axialCoordinates.x, axialCoordinates.y]
    axialCoordinatesLabel.text = axialCoordinatesText    
    axialCoordinatesLabel.rect_position = Vector2(
        center.x - axialCoordinatesLabel.rect_size.x / 2,
        center.y
    )
    
    set_points(
        PoolVector2Array([
            corner(center, 0),
            corner(center, 1),
            corner(center, 2),
            corner(center, 3),
            corner(center, 4),
            corner(center, 5),
            corner(center, 0)
        ])
    )
    
    #bounds.editor_only = !debug
    coordinatesLabel.visible = debug
    axialCoordinatesLabel.visible = debug
    
    update()
    
func update():
    if isHighlighted:
        z_index = 1
        default_color = Color(0.9,0.9,0.9)
    else:
        z_index = 0
        default_color = Color(0.4,0.4,0.4)
          
# From https://www.redblobgames.com/grids/hexagons/
func corner(center, i):
    var angleDeg = 60 * i
    var angleRad = PI / 180 * angleDeg
    return Vector2(
        center.x + size * cos(angleRad),
        center.y + size * sin(angleRad)
    )
