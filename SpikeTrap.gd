extends StaticBody2D

func _physics_process(delta):	
	$CollisionShape2D.disabled = true

func _on_Area2D_body_shape_entered(body_id, body, body_shape, area_shape):
	print(body)
	
	if body.name == "Player":
		$AnimatedSprite.play("out")
		$CollisionShape2D.disabled = false
		#$Timer.start()

func _on_Timer_timeout():
	$AnimatedSprite.play("retract")
	$CollisionShape2D.disabled = true


func _on_AnimatedSprite_animation_finished():
	$Timer.start()
