extends ColorRect

export var dialog_path = ""
export(float) var text_speed = 0.05

var dialog
var phrase_num = 0
var finished = false
export var tiempo_post_chat = 2
var tiempo_adicional = tiempo_post_chat


func _ready():
	$Timer.wait_time = text_speed
	new_dialog(dialog_path)
	
func _process(delta):
#	if Input.is_action_just_pressed("click"):
#		if finished:
#			next()
#		else:
#			$Texto.visible_characters = len($Texto.text)
	if finished:
		tiempo_adicional -= delta
	if tiempo_adicional <= 0:
		next()
		tiempo_adicional = tiempo_post_chat
		

func next():
	if phrase_num >= len(dialog):
		visible = false
		return
	
	finished = false
	$TextBox/Text.bbcode_text = dialog[phrase_num]["Texto"]
	$NameBox/Name.bbcode_text = dialog[phrase_num]["Nombre"]
	
	$TextBox/Text.visible_characters = 0
	#$NameBox/Name.visible = false
	
	
	while $TextBox/Text.visible_characters < len($TextBox/Text.bbcode_text):
		$TextBox/Text.visible_characters += 1
		$Timer.start()
		yield($Timer, "timeout")
		
	finished = true
	phrase_num += 1
	
	return

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
