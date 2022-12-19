extends RayCast2D


# Declare member variables here. Examples:
var is_casting := false setget set_is_casting


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	$Line2D.points[1] = Vector2.ZERO
	self.is_casting = true

#func _unhandled_input(event: InputEvent):
#	if event is InputEventMouseButton:
#		self.is_casting = event.pressed
#		print(event.pressed)


func _physics_process(_delta):
	var cast_point := cast_to
	force_raycast_update()
	
	if is_colliding():
		cast_point = to_local(get_collision_point())
		
	$Line2D.points[1] = cast_point

func set_is_casting(cast: bool) -> void:
	is_casting = cast
	set_physics_process(is_casting)
	if is_casting:
		appear()
	else:
		disappear()

func appear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 10.0, 0.2)
	$Tween.start()
	
func disappear():
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.1)
	$Tween.start()
