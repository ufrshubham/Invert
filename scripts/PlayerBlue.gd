extends KinematicBody2D

signal black_collision
signal camera_shake_requested

onready var black = get_parent().get_node("Black")

func _process(_delta: float) -> void:
	if abs(get_position().distance_to(black.get_position())) < 64:
		$AudioStreamPlayer.play()
		emit_signal("camera_shake_requested")
		emit_signal("black_collision")
	
