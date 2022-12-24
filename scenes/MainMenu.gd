extends Control



func _on_Play_pressed():
	get_tree().change_scene("res://scenes/TestScene.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://scenes/Credits.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
