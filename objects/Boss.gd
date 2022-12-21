extends KinematicBody2D


# Declare member variables here.
var changing_path = false
var destination : Vector2
export var speed = 0

export var max_life = 100
var life = max_life

export var rate_of_fire = 2.5
var reload_time = 1/rate_of_fire

export var giracion = 5
var angulos_sumados = 360/giracion
var angulo = 0

export(PackedScene) var bullet_scene = preload("res://objects/bullet.tscn")

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if changing_path:
		var vector = (destination - self.position).normalized()
		move_and_slide(vector * speed)
	
	reload_time -= delta
	if reload_time <= 0:
#		$Shooter.shoot_to_tree(200, 6, bullet_scene, 80, Vector2(20,-20))
#		$Shooter.shoot_to_tree(200, 6, bullet_scene, 90)
#		$Shooter.shoot_to_tree(200, 6, bullet_scene, 100, Vector2(-20, -20))
		
		angulo = 0
		while angulo < 360:
#			$Shooter.shoot_to_tree(400, 6, bullet_scene, angulo, Vector2(0,300), 2)
#			$Shooter.shoot_to_tree(400, 6, bullet_scene, angulo, Vector2(0,300), -2)
			
			#$Rotator1/Shooter.shoot_to_tree(200, 6, bullet_scene, angulo)
			#$Rotator2/Shooter.shoot_to_tree(200, 6, bullet_scene, angulo)
			angulo += angulos_sumados
		reload_time = 1/rate_of_fire


func move_to(objective):
	changing_path = true
	destination = objective
	
func stop():
	self.position = Vector2(0,0)
	changing_path = false



func _on_Hurtbox_body_entered(body):
	life -= body.damage
	body.queue_free()
