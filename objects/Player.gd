extends KinematicBody2D


# Declare member variables here.
export var rate_of_fire = 2.5
var reload_time = 1/rate_of_fire
export var max_angulo = 7.5
var angulo = max_angulo

export var movible = true

var shooter : Node2D
export(PackedScene) var bullet_scene = preload("res://objects/bullet.tscn")

export var movespeed = 450

onready var BossLair = get_node("../BossLair")

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
	if movible:
# warning-ignore:return_value_discarded
		move_and_slide(motion * movespeed)
	else:
		var detector = move_and_slide(Vector2(0, 1) * movespeed)
		if detector != null:
			var trackers = get_tree().get_nodes_in_group("tracker")
			for tracker in trackers:
				tracker.queue_free()
			# warning-ignore:return_value_discarded
			get_tree().change_scene("res://scenes/Ending.tscn")
	
	reload_time -= delta
	if reload_time <= 0 and movible:
		shooter.shoot_to_tree(1000, 3, bullet_scene, 90 + 180 - angulo, Vector2(-20,0))
		shooter.shoot_to_tree(1000, 3, bullet_scene, 90 + 180)
		shooter.shoot_to_tree(1000, 3, bullet_scene, 90 + 180 + angulo, Vector2(20, 0))
		$Teletrack1/Shooter.shoot_to_tree(600, 3, bullet_scene, 0, Vector2(0, 0), 0, 0, BossLair)
		$Teletrack2/Shooter.shoot_to_tree(600, 3, bullet_scene, 0, Vector2(0, 0), 0, 0, BossLair)
		reload_time = 1/rate_of_fire
	
	


func _on_Area2D_body_entered(body):
	if not movible:
		return
	BossLair.camera_shake()
	body.queue_free()
	$AudioStreamPlayer.play()
	pass # Replace with function body.
