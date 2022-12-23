extends Node2D


# Declare member variables here. Examples:
export var rot_speed = 30
var mirar_izquierda = false
onready var player = get_node("../../../../../Player")

func _process(delta):
	look_at(player.position)
	if $Shooter.rotation_degrees >= 90 and $Shooter.rotation_degrees <= 90 + 180:
		if not mirar_izquierda:
			cambiar_mirada()
	elif mirar_izquierda:
		cambiar_mirada()

func cambiar_mirada():
	mirar_izquierda = not mirar_izquierda
	$Shooter/SnowGun.scale = $Shooter/SnowGun.scale * Vector2(1, -1)
