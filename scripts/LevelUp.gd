extends Area2D

export(PackedScene) var NextLevel

enum Type { LevelUp, Play, Quit }
export(Type) var type = Type.LevelUp

var _no_no = false
var _go_to_next = false
var _quit = false

signal reset_players
signal camera_shake_requested

func go_to_next_scene():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(NextLevel)


func _on_LevelUp_area_entered(area: Area2D) -> void:
	$Timer.start()
	
	if type == Type.LevelUp:
		if area.is_in_group("White"):
			_go_to_next = true
		elif area.is_in_group("Black"):
			_no_no = true
			get_parent().get_node("NoNo").visible = true
			emit_signal("camera_shake_requested")
	elif type == Type.Play:
		_go_to_next = true
	elif type == Type.Quit:
		_quit = true


func _on_Timer_timeout() -> void:
	if _go_to_next:
		go_to_next_scene()
	elif _quit:
		get_tree().quit()
	elif _no_no:
		get_parent().get_node("NoNo").visible = false
		_no_no = false
		emit_signal("reset_players")
