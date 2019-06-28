#worldender.gd
extends Area2D

export(String,FILE, "*.tscn") var world_scene
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	print(bodies)
	for body in bodies:
		if body.name == "Player":
			get_tree().change_scene(world_scene)