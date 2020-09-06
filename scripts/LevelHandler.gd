extends Node2D


var _white_player_pos : Vector2
var _black_player_pos : Vector2


func _ready() -> void:
	_white_player_pos = $White.get_position()
	_black_player_pos = $Black.get_position()
	
	$White.connect("black_collision", self, "_reset_player_position")
	

func _on_White_black_collision() -> void:
	_reset_player_position()


func _reset_player_position():
	$White.set_position(_white_player_pos)
	$Black.set_position(_black_player_pos)
