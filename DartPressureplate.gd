extends Area2D
const PROJECTILE = preload("res://Scenes/DartTrap.tscn")
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
			