extends Area2D

func _on_Playfield_body_entered(body):
	body.queue_free()
