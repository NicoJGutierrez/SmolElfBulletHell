extends Node2D

export var rate_of_fire = 2.5
var reload_time = 1/rate_of_fire
export var hail_qtty = 5
export(PackedScene) var bullet_scene = preload("res://objects/bullet.tscn")

var angulo = 0

export var change_path_time_limit = 6
var change_path_time = change_path_time_limit
var changing_path = false

onready var boss = get_node("Path1/PathFollow/Boss")
onready var progress_bar = get_node("../UIHolder/UI/ProgressBar")
onready var chatbox = get_node("../UIHolder/UI/DialogBox")
onready var children = get_children()
var current_path = 1
var next_path = current_path + 1

var boss_phase = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if change_path_time <= 0:
		change_path_time = change_path_time_limit
		changing_path = true
		
		next_path = current_path + 1
		if next_path > children.size():
			next_path = 1
		var boss_position = children[current_path - 1].get_child(0).position
		children[current_path - 1].get_child(0).remove_child(boss)
		self.add_child(boss)
		boss.position = boss_position
		
		
		
		#var objective = $Path2/PathFollow.position
		
	if changing_path:
		var objective = children[next_path - 1].get_child(0).position
		boss.move_to(objective)
		if boss.position.distance_to(children[next_path - 1].get_child(0).position) <= 5:
			self.remove_child(boss)
			children[next_path - 1].get_child(0).add_child(boss)
			current_path = next_path
			boss.stop()
			changing_path = false
	else:
		change_path_time -= delta
		children[current_path - 1].get_child(0).offset += boss.speed * delta

	progress_bar.value = boss.life
	if boss.life < 95 and boss_phase == 1:
		phase_2()
	if boss_phase == 2:
		#angulo semirandom
		if angulo >= 90:
			angulo += delta * 45.3 - 90
		angulo += delta * 45.3
		
		#disparo
		reload_time -= delta
		if reload_time <= 0:
			var mini_angulo = angulo
			for i in range(hail_qtty):
				$Shooter.shoot_child(300, 25, bullet_scene, mini_angulo)
				$Container2/Shooter2.shoot_child(300, 25, bullet_scene, mini_angulo + 90)
				if mini_angulo + 90/hail_qtty >= 90:
					mini_angulo += 90/hail_qtty - 90 
				else:
					mini_angulo += 90/hail_qtty
			reload_time = 1/rate_of_fire

func phase_2():
	boss_phase = 2
	chatbox.new_dialog("Texto/Dialogo2.json")
