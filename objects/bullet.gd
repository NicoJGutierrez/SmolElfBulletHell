extends RigidBody2D


# Declare member variables here. Examples:
export var tiempo_de_vida = 5
export var velocidad_inicial = 200
export var roce = 1
export var damage = 0.1
export var curve = 0
var follow = null

func _ready():
	if curve == 0:
		apply_central_impulse(Vector2(velocidad_inicial,0).rotated(self.rotation))
		set_linear_damp(roce)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if curve != 0 and follow == null:
		set_angular_velocity(curve)
		set_linear_velocity(Vector2(velocidad_inicial,0).rotated(self.rotation))
	elif follow != null:
		set_linear_velocity(Vector2(velocidad_inicial,0).rotated(get_angle_to(follow.boss_pos())))
	
	if tiempo_de_vida < 998:
		tiempo_de_vida -= delta
	elif tiempo_de_vida <= 0:
			queue_free()
