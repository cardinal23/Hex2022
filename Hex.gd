extends Line2D

var size = 400
var coordinates: Vector2
onready var bounds = $Bounds

func _init():
    width = 2.0
    default_color = Color(0.4,0.4,0.4)
    
func _ready():
    var center = Vector2(
        position.x + size,
        position.y + (sqrt(3) * size) / 2
    )
    
    bounds.rect_min_size = Vector2(size, size)
    
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
    
func _draw():
    #print(position)
    var debug := true
    
    if debug:
        var borderRect = Rect2(position, Vector2(size * 2, sqrt(3) * size))
        draw_rect(borderRect, Color.antiquewhite, false) 
    
# From https://www.redblobgames.com/grids/hexagons/
func corner(center, size, i):
    var angleDeg = 60 * i
    var angleRad = PI / 180 * angleDeg
    return Vector2(
        center.x + size * cos(angleRad),
        center.y + size * sin(angleRad)
    )
