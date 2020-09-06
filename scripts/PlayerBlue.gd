extends KinematicBody2D

signal black_collision

onready var black = get_parent().get_node("Black")

func _process(delta: float) -> void:
	if abs(get_position().distance_to(black.get_position())) < 64:
		emit_signal("black_collision")
	
