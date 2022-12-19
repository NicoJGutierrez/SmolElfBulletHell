extends KinematicBody2D


# Declare member variables here.
export var rate_of_fire = 2.5
var reload_time = 1/rate_of_fire
export var max_angulo = 7.5
var angulo = max_angulo
export var movespeed = 600
var shooter : Node2D
export(PackedScene) var bullet_scene = preload("res://objects/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	shooter = get_node("Shooter")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	motion = motion.normalized()
	if Input.is_action_pressed("run"):
		motion.x = 0.5 * motion.x
		motion.y = 0.5 * motion.y
		$AnimatedSprite.modulate.a = 0.5
		angulo = 0
	else:
		$AnimatedSprite.modulate.a = 1
		angulo = max_angulo
	
# warning-ignore:unused_variable
	var detector_de_colisiones = move_and_slide(motion * movespeed)
	
	reload_time -= delta
	if reload_time <= 0:
		shooter.shoot_to_tree(2000, 3, bullet_scene, 90 + 180 - angulo, Vector2(-20,0))
		shooter.shoot_to_tree(2000, 3, bullet_scene, 90 + 180)
		shooter.shoot_to_tree(2000, 3, bullet_scene, 90 + 180 + angulo, Vector2(20, 0))
		reload_time = 1/rate_of_fire
	
	
