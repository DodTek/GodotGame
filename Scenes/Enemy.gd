extends KinematicBody2D
#if animation issues with projectile clashing with other animations check https://youtu.be/pSv9_W1rGtI - 10 minutes in
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200

const PROJECTILE = preload("res://Scenes/projectile.tscn")

var motion = Vector2()
var direction = 1
var is_dead = false

func _ready():
	pass

func dead():
	is_dead = true
	$Timer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_dead == false:
		motion.x  = SPEED * direction
		if direction == 1:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
		
		motion.y += GRAVITY
		
		motion = move_and_slide(motion, UP)
	else:
		motion = Vector2(0, 0)
		$AnimatedSprite.play("dead")
		$CollisionShape2D.disabled = true
		
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() ==false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	if get_slide_count() > 0:	
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
					get_slide_collision(i).collider.dead()		

func _on_Timer_timeout():
	queue_free()
