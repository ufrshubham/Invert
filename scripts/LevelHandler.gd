extends Node2D


var _white_player_pos : Vector2
var _black_player_pos : Vector2


func _ready() -> void:
	_white_player_pos = $White.get_position()
	_black_player_pos = $Black.get_position()
	
# warning-ignore:return_value_discarded
	$White.connect("black_collision", self, "_on_White_black_collision")
	

func _on_White_black_collision() -> void:
	$Timer.start()
	get_tree().paused = true


func _reset_player_position():
	$White.zero_velocity()
	$Black.zero_velocity()
	
	$White.set_position(_white_player_pos)
	$Black.set_position(_black_player_pos)


func _on_Timer_timeout() -> void:
	_reset_player_position()
	get_tree().paused = false


func _on_LevelUp_reset_players() -> void:
	_reset_player_position()
