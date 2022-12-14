extends RigidBody2D


# Declare member variables here. Examples:
export var rate_of_fire = 2.5
var reload_time = 1/rate_of_fire

export var rotation_speed = 400


var angulo = 0
export(PackedScene) var bullet_scene = preload("res://objects/bullet.tscn")
export var balas_disparadas = 12
var shooter : Node2D

export var velocidad_inicial = 0
export var roce = 1
export var tiempo_de_vida = 999

# Called when the node enters the scene tree for the first time.
func _ready():
	shooter = get_node("Shooter")
	apply_central_impulse(Vector2(velocidad_inicial,0).rotated(self.rotation))
	set_linear_damp(roce)
	
	pass # Replace with function body.


func _process(delta):
	
	
	#tiempo de vida
	if tiempo_de_vida < 998:
		tiempo_de_vida -= delta
	if tiempo_de_vida <= 0:
			destroy()
	
	#disparo
	if reload_time < 998:
		reload_time -= delta
	if reload_time <= 0:
#		shooter.shoot_to_tree(100, 3, bullet_scene)
#		shooter.shoot_to_tree(200, 3, bullet_scene)
#		shooter.shoot_to_tree(300, 3, bullet_scene)
		for i in range(balas_disparadas):
			shooter.shoot_child(300, 3, bullet_scene, angulo + i * (360/balas_disparadas), 0.2)
		angulo += 10
		reload_time = 1/rate_of_fire

func destroy():
	#destruir solo si no hay balas en el aire
	reload_time = 999
	$AnimatedSprite.hide()
	if get_child_count() < 4:
		queue_free()

