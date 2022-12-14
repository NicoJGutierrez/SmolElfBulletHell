extends Node2D

export (PackedScene) var bullet

func shoot_to_tree(vel, tiempo_de_vida, objeto, angulo = 0, displacement = Vector2(0,0), curve = 0, roce = 0, follow = null):
	if bullet != null:
		objeto = bullet
	var bullet = objeto.instance()
	bullet.position = get_global_position() + displacement
	bullet.rotation_degrees = rotation_degrees + angulo
	bullet.velocidad_inicial = vel
	bullet.curve = curve
	bullet.roce = roce
	bullet.tiempo_de_vida = tiempo_de_vida
	bullet.follow = follow
	
	get_tree().get_root().call_deferred("add_child", bullet)
	return bullet

func shoot_child(vel, tiempo_de_vida, objeto, angulo = 0, displacement = Vector2(0,0), curve = 0, roce = 0):
	var bullet = objeto.instance()
	bullet.rotation_degrees = rotation_degrees + angulo
	bullet.velocidad_inicial = vel
	bullet.curve = curve
	bullet.roce = roce
	bullet.tiempo_de_vida = tiempo_de_vida
	add_child(bullet)
	bullet.position += displacement
	return bullet

	

