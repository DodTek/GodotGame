extends Area2D

var direction = -1
var x = false
const PROJECTILE = preload("res://Scenes/dart.tscn")
var reloaded = true


func _physics_process(delta):
	if (x == true && reloaded == true):
		var project = PROJECTILE.instance()
		project.set_projectile_direction(-1)
		get_parent().add_child(project)
		project.position = $Position2D.global_position
		x = false
		reloaded = false
		$Timer.start()
		
func change_x(body_id, body, body_shape, area_shape):
	if body.name == "Player":
		x = true
	


func _on_Timer_timeout():
	reloaded = true


func _on_Area2D2_body_entered(body):
	pass # Replace with function body.
