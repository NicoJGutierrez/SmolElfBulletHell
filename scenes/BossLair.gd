extends Node2D


export var change_path_time_limit = 6
var change_path_time = change_path_time_limit
var changing_path = false

onready var boss = get_node("Path1/PathFollow/Boss")
onready var progress_bar = get_node("../UI/ProgressBar")
onready var children = get_children()
var current_path = 1
var next_path = current_path + 1

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

	progress_bar.value = boss.life
