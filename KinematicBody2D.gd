extends KinematicBody2D
const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP_HEIGHT = -500
const PROJECTILE = preload("res://Scenes/projectile.tscn")
var motion = Vector2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var friction = false
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"): 
		"""min is used to set a max speed, acceleration is added to motion until it reaches max speed"""
		motion.x  = min(motion.x + ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")

	elif Input.is_action_pressed("ui_left"):
		"""max is used to set a max speed, acceleration is added to motion until it reaches max speed"""
		motion.x  = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	
	if Input.is_action_just_pressed("ui_focus_next"):
		var project = PROJECTILE.instance()
		get_parent().add_child(project)
		project.position = $Position2D.global_position
	
	else:
		friction = true
		$Sprite.play("idel")
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			"""lerp is used for friction it reduces the speed to 0 by 0.2 every frame"""
			motion.x = lerp(motion.x, 0, 0.15)
			
				
	else:
		if motion.y < 0:
			$Sprite.play("jump")
		else:
			$Sprite.play("fall")
		if friction == true:
			"""lerp is used for friction it reduces the speed to 0 by 0.2 every frame"""
			motion.x = lerp(motion.x, 0, 0.05)
		
			
	if is_on_wall():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			"""
			if $Sprite.flip_h == true:
				motion.x = -SPEED
			else:
				motion.x = SPEED
			"""
			$Sprite.play("jump")
		
	motion = move_and_slide(motion, UP)
	pass