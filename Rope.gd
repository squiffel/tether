extends Line2D

export var length = 100

func _ready():
	rset_config("points", MultiplayerAPI.RPC_MODE_REMOTE)
	rset_config("visible", MultiplayerAPI.RPC_MODE_REMOTE)
	add_point(Vector2.ZERO)

func _process(delta):
	if is_network_master():
		rset("visible", visible)
		rset("points", points)
		
func push(point):
	add_point(point, 1)

func pop():
	remove_point(1)

func pivot():
	if points.size() > 1:
		return points[1]

func is_tethered():
	return points.size() > 1

func previous_pivot():
	if points.size() > 2:
		return points[2]
		
func update_body_pos(pos):
	set_point_position(0, pos)

func reset():
	var body_pos = points[0]
	clear_points()
	add_point(body_pos)
