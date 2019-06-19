extends Area2D



func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if body.name == "Player":
		body.on_rope()

func _on_Area2D_body_shape_exited(body_id, body, body_shape, area_shape):
	if body.name == "Player":
		body.off_rope()
