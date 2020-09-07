extends Camera2D

export(NodePath) var Player1
export(NodePath) var Player2

export(float) var Zoom_Min
export(float) var Zoom_Max

export var amplitude := 6.0
export var duration := 0.8 setget set_duration
export(float, EASE) var DAMP_EASING := 1.0
export var shake := false setget set_shake
onready var timer : Timer = $Timer

var player1_node : Node2D
var player2_node : Node2D

func _ready() -> void:
	player1_node = get_node(Player1)
	player2_node = get_node(Player2)
	
	randomize()
	# set_process(false)
	self.duration = duration
	connect_to_shakers()
	
	
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
	
	var damping := ease(timer.time_left / timer.wait_time, DAMP_EASING)
	offset = Vector2(
		rand_range(amplitude, -amplitude) * damping, 
		rand_range(amplitude, -amplitude) * damping)


func _on_Timer_timeout():
	self.shake = false


func _on_camera_shake_requested():
	self.shake = true


func set_duration(value):
	duration = value
	if timer != null:
		timer.set_wait_time(duration)


func set_shake(value:bool):
	shake = value
	# set_process(true)
	offset = Vector2()
	if shake:
		timer.start()


func connect_to_shakers():
	for camera_shaker in get_tree().get_nodes_in_group("camera_shaker"):
		camera_shaker.connect("camera_shake_requested", self, "_on_camera_shake_requested")

