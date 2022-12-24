extends KinematicBody2D


# Declare member variables here.
var changing_path = false
var destination : Vector2
export var speed = 0

export var max_life = 100
var life = max_life

export var rate_of_fire = 2.5
var reload_time = 1/rate_of_fire
export var clip_size = 7
var bullets = clip_size

export var giracion = 8
var angulos_sumados = 360/giracion
var angulo = 0

export var fase = 1

export(PackedScene) var bullet_scene = preload("res://objects/bullet.tscn")

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if changing_path:
		var vector = (destination - self.position).normalized()
# warning-ignore:return_value_discarded
		move_and_slide(vector * speed)
	
	if fase == 3:
		$Shooter.rotate(0.5 * delta)
	
	reload_time -= delta
	if reload_time <= 0:
		reload_time = 1/rate_of_fire
		if fase == 1:
			$Shooter.shoot_to_tree(250, 6, bullet_scene, 80, Vector2(20,-20))
			$Shooter.shoot_to_tree(250, 6, bullet_scene, 90)
			$Shooter.shoot_to_tree(250, 6, bullet_scene, 100, Vector2(-20, -20))
		
		if fase == 2:
			if bullets > 0:
				bullets -= 1
				$Rotator1/Shooter.shoot_to_tree(400, 6, bullet_scene, $Rotator1.rotation_degrees)
			elif bullets == 0:
				bullets = -1
				angulo = 0
				while angulo < 360:
					$Shooter.shoot_to_tree(200, 6, bullet_scene, angulo)
					angulo += 360/(3*giracion)
			else:
				bullets = clip_size
		
		if fase == 3 and not changing_path:
			angulo = 0
			while angulo < 360:
				angulo += angulos_sumados
				$Shooter.shoot_child(300, 6, bullet_scene, angulo, Vector2(0,0), 0.35)
				$Shooter.shoot_child(300, 6, bullet_scene, angulo, Vector2(0,0), -0.35)
				#$Rotator1/Shooter.shoot_to_tree(200, 6, bullet_scene, angulo)
				#$Rotator2/Shooter.shoot_to_tree(200, 6, bullet_scene, angulo)


func move_to(objective):
	changing_path = true
	destination = objective
	
func stop():
	self.position = Vector2(0,0)
	changing_path = false

func toggle_snow_gun():
	if $Rotator1/SnowGun.visible:
		$Rotator1/SnowGun.hide()
	else:
		$Rotator1/SnowGun.show()
		
func play_phase_change():
	$AudioStreamPlayer.play()

func _on_Hurtbox_body_entered(body):
	life -= body.damage
	body.queue_free()
