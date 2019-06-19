#if animation issues with projectile clashing with other animations check https://youtu.be/pSv9_W1rGtI - 10 minutes in
extends KinematicBody2D
const UP = Vector2(0, -1)
var GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP_HEIGHT = -500
const PROJECTILE = preload("res://Scenes/projectile.tscn")

var motion = Vector2()
var is_attacking = false
var is_dead = false
var on_rope = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var friction = false
	motion.y += GRAVITY
	if is_dead == false:
		if Input.is_action_pressed("ui_right"): 
			if is_attacking == false || is_on_floor() == false:
				"""min is used to set a max speed, acceleration is added to motion until it reaches max speed"""
				motion.x  = min(motion.x + ACCELERATION, MAX_SPEED)
				
				if is_attacking == false:
					$Sprite.flip_h = false
					$Sprite.play("run")
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
	
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false || is_on_floor() == false:
				"""max is used to set a max speed, acceleration is added to motion until it reaches max speed"""
				motion.x  = max(motion.x - ACCELERATION, -MAX_SPEED)
				"""Stops sprite flipping in air"""
				if is_attacking == false:
					$Sprite.flip_h = true
					$Sprite.play("run")
					if sign($Position2D.position.x) == 1:
						$Position2D.position.x *= -1
		else:
			if is_on_floor() && is_attacking == false: 
				friction = true
				$Sprite.play("idel")
			
		if Input.is_action_just_pressed("ui_focus_next") && is_attacking == false:
			if is_on_floor():
				motion.x = 0
			is_attacking = true
			$Sprite.play("shoot")
			var project = PROJECTILE.instance()
			if sign($Position2D.position.x) == 1:
				project.set_projectile_direction(1)
			else:
				project.set_projectile_direction(-1)
			get_parent().add_child(project)
			project.position = $Position2D.global_position
	
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				"""lerp is used for friction it reduces the speed to 0 by 0.2 every frame"""
				motion.x = lerp(motion.x, 0, 0.15)
		else:
			if is_attacking == false:
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
		
		if get_slide_count() > 0:	
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
						dead()
	
		if on_rope == true:
			GRAVITY = 0
			motion.x = lerp(motion.x, 0, 0.07)
			if Input.is_action_pressed("ui_up"):
				motion.y = -ACCELERATION
				
			elif Input.is_action_pressed("ui_down"):
				motion.y = ACCELERATION
				
			else:
				motion.y = 0
		else:
			GRAVITY = 20
	
	else:
		$Sprite.play("dead")
		motion.y += GRAVITY
		motion = Vector2(0,0)
		$CollisionShape2D.disabled = true
	pass
			
func dead():
	is_dead = true
	$Timer.start()
	
func on_rope():
	on_rope = true
	
func off_rope():
	on_rope = false
func _on_Sprite_animation_finished():
	is_attacking = false


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/Menu.tscn")
