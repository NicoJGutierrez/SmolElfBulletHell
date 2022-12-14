extends Node2D

func shoot_to_tree(vel, tiempo_de_vida, objeto, angulo = 0, roce = 1):
	var bullet = objeto.instance()
	bullet.position = get_global_position()
	bullet.rotation_degrees = rotation_degrees + angulo
	bullet.velocidad_inicial = vel
	bullet.roce = roce
	bullet.tiempo_de_vida = tiempo_de_vida
	
	get_tree().get_root().call_deferred("add_child", bullet)
	return bullet

func shoot_child(vel, tiempo_de_vida, objeto, angulo = 0, roce = 1):
	var bullet = objeto.instance()
	bullet.rotation_degrees = rotation_degrees + angulo
	bullet.velocidad_inicial = vel
	bullet.roce = roce
	bullet.tiempo_de_vida = tiempo_de_vida
	get_parent().add_child(bullet)
	return bullet
	

