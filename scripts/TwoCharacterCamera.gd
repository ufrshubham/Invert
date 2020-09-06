extends Camera2D

export(NodePath) var Player1
export(NodePath) var Player2

export(float) var Zoom_Min
export(float) var Zoom_Max

var player1_node : Node2D
var player2_node : Node2D

func _ready() -> void:
	player1_node = get_node(Player1)
	player2_node = get_node(Player2)
	
	
func _process(_delta: float) -> void:
	var player1_pos : Vector2 = player1_node.get_global_position()
	var player2_pos : Vector2 = player2_node.get_global_position()
	
	position = (player1_pos + player2_pos) / 2
	
	var distance_between : float = player1_pos.distance_to(player2_pos)
	zoom.x = max(Zoom_Min, distance_between/1000)
	zoom.y = max(Zoom_Min, distance_between/1000)
	
	if zoom.x > Zoom_Max:
		zoom.x = Zoom_Max
		zoom.y = Zoom_Max
