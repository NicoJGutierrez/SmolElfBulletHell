extends ColorRect

export var dialog_path = ""
export(float) var text_speed = 0.05

var dialog
var phrase_num = 0
var finished = false
var tiempo_adicional = 2


func _ready():
	$Timer.wait_time = text_speed
	dialog = get_dialog()
	next()
	
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

func next():
	if phrase_num >= len(dialog):
		visible = false
		return
	
	finished = false
	$TextBox/Text.bbcode_text = dialog[phrase_num]["Texto"]
	$NameBox/Name.bbcode_text = dialog[phrase_num]["Nombre"]
	
	$TextBox/Text.visible_characters = 0
	#$NameBox/Name.visible = false
	
	
	while $TextBox/Text.visible_characters < len($TextBox/Text.text):
		$TextBox/Text.visible_characters += 1
		$Timer.start()
		yield($Timer, "timeout")
		
	finished = true
	phrase_num += 1
	
	return
	
func get_dialog():
	#aquí hay un error
	var f = File.new()
	assert(f.file_exists(dialog_path), "No hay diálogo")
	f.open(dialog_path, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
