extends Node2D

export var rate_of_fire = 2.5
var reload_time = 1/rate_of_fire
export var hail_qtty = 5
export(PackedScene) var bullet_scene = preload("res://objects/bullet.tscn")

var angulo = 0
var shapechanger = true

export var change_path_time_limit = 6
var change_path_time = change_path_time_limit
var changing_path = false

onready var boss = get_node("Path1/PathFollow/Boss")
onready var progress_bar = get_node("../UIHolder/UI/ProgressBar")
onready var chatbox = get_node("../UIHolder/UI/DialogBox")
onready var children = get_children()
var current_path = 1
var next_path = current_path + 1

# Called when the node enters the scene tree for the first time.
func _ready():
	children.remove(children.size() - 1)
	children.remove(children.size() - 1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
#	if change_path_time <= 0:
#		change_path_time = change_path_time_limit
#		boss_change_path()

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
	if boss.life < 80 and boss.fase == 1:
		phase_2()
	if boss.life < 50 and boss.fase == 2:
		phase_3()
	if boss.life < 20 and boss.fase == 3:
		phase_4()
	
	
	if boss.fase == 4:
		if angulo >= 90:
			angulo += 21 - 90
		angulo += 21
		
		#disparo
		reload_time -= delta
		
		if reload_time <= 0:
			var mini_angulo = angulo
			if shapechanger:
				shapechanger = false
			else:
				shapechanger = true
			for i in range(hail_qtty):
				if shapechanger:
					$Shooter.shoot_child(250, 25, bullet_scene, 90 - mini_angulo)
					$Container2/Shooter2.shoot_child(250, 25, bullet_scene, 90 + mini_angulo)
				else:
					$Shooter.shoot_child(250, 25, bullet_scene, mini_angulo)
					$Container2/Shooter2.shoot_child(250, 25, bullet_scene, 180 - mini_angulo)
				
				if mini_angulo + 90/hail_qtty >= 90:
					mini_angulo += 90/hail_qtty - 90 
				else:
					mini_angulo += 90/hail_qtty
			reload_time = 1/rate_of_fire

func boss_pos():
	if boss.changing_path:
		return boss.position
	else:
		return boss.get_parent().position

func boss_change_path():
	changing_path = true
	next_path = current_path + 1
	if next_path > children.size():
		next_path = 1
	var boss_position = children[current_path - 1].get_child(0).position
	children[current_path - 1].get_child(0).remove_child(boss)
	self.add_child(boss)
	boss.position = boss_position

func phase_2():
	boss_change_path()
	boss.rate_of_fire = boss.rate_of_fire * 4
	boss.toggle_snow_gun()
	boss.fase = 2
	chatbox.new_dialog("Texto/Dialogo2.json")
	
func phase_3():
	boss_change_path()
	boss.rate_of_fire = boss.rate_of_fire / 2
	boss.toggle_snow_gun()
	boss.fase = 3
	
func phase_4():
	boss.fase = 4
