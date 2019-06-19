extends RigidBody2D


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$AnimatedSprite.play("normal")

func _on_Timer_timeout():
	$AnimatedSprite.play("broken")

func _on_Pitfall_body_entered(body):
	print("hey")
	$AnimatedSprite.play("damaged")


