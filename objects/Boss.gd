extends KinematicBody2D


# Declare member variables here.
var changing_path = false
var destination : Vector2
export var speed = 300
export var life = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if changing_path:
		var vector = (destination - self.position).normalized()
		move_and_slide(vector * speed)


func move_to(objective):
	changing_path = true
	destination = objective
	
func stop():
	self.position = Vector2(0,0)
	changing_path = false



func _on_Hurtbox_body_entered(body):
	life -= body.damage
	body.queue_free()
