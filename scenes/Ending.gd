extends Node2D

export var end_speed = 2.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = end_speed
	story()


func story():
	$Timer.start()
	yield($Timer, "timeout")
	$Timer.start()
	yield($Timer, "timeout")
	$ending1.hide()
	$Timer.start()
	yield($Timer, "timeout")
	$ending2.hide()
	$Timer.start()
	yield($Timer, "timeout")
	$ending3.hide()

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
