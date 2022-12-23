extends ColorRect

export var dialog_path = ""
export(float) var text_speed = 0.05

var dialog
var phrase_num = 0
export var tiempo_post_chat = 2.0
var tiempo_adicional = tiempo_post_chat


func _ready():
	$Timer.wait_time = text_speed
	$TextCompleteTimer.wait_time = tiempo_post_chat
	new_dialog(dialog_path)
	
func _process(delta):
#	if Input.is_action_just_pressed("click"):
#		if finished:
#			next()
#		else:
#			$Texto.visible_characters = len($Texto.text)
	pass
		

func next():
	get_tree().paused = true
	while true:
		if phrase_num >= len(dialog):
			visible = false
			break
		
		$TextBox/Text.bbcode_text = dialog[phrase_num]["Texto"]
		$NameBox/Name.bbcode_text = dialog[phrase_num]["Nombre"]
		
		$TextBox/Text.visible_characters = 0
		#$NameBox/Name.visible = false
		
		
		while $TextBox/Text.visible_characters < len($TextBox/Text.bbcode_text):
			$TextBox/Text.visible_characters += 1
			if $TextBox/Text.visible_characters % 2 == 1:
				$AudioStreamPlayer.play()
			$Timer.start()
			yield($Timer, "timeout")
			
		$TextCompleteTimer.start()
		yield($TextCompleteTimer, "timeout")
		phrase_num += 1
	get_tree().paused = false

func get_dialog(path):
	#aquí hay un error
	var f = File.new()
	assert(f.file_exists(path), "No hay diálogo")
	f.open(path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func new_dialog(path):
	visible = true
	phrase_num = 0
	dialog = get_dialog(path)
	next()
	
