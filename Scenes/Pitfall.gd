extends StaticBody2D
var broken = false
func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	if broken == false:
		if body.name == "Player":
			$AnimatedSprite.play("damaged")
			$Timer.start()
		else:
			$AnimatedSprite.play("normal")
	if broken == true:
		$AnimatedSprite.play("broken")

func _on_Timer_timeout():
	
	$AnimatedSprite.play("broken")
	$CollisionShape2D.disabled = true
	broken = true
