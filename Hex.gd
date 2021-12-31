extends Line2D

var size: int = 80

func _init():
    antialiased = true
    width = 2.0
    default_color = Color(0.4,0.4,0.4)
    
    var center = Vector2(100,100)
    set_points(
        PoolVector2Array(
            [
                corner(center, size, 0),
                corner(center, size, 1),
                corner(center, size, 2),
                corner(center, size, 3),
                corner(center, size, 4),
                corner(center, size, 5),
                corner(center, size, 0)
               ]
           )
       )
    
# From https://www.redblobgames.com/grids/hexagons/
func corner(center, size, i):
    var angleDeg = 60 * i
    var angleRad = PI / 180 * angleDeg
    return Vector2(
        center.x + size * cos(angleRad),
        center.y + size * sin(angleRad)
    )
