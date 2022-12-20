extends Node2D


# Declare member variables here. Examples:
export var rot_speed = 30

func _process(delta):
	$Shooter.rotation_degrees += (rot_speed * delta)
