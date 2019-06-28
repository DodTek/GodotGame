extends KinematicBody2D
#if animation issues with projectile clashing with other animations check https://youtu.be/pSv9_W1rGtI - 10 minutes in
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200

const PROJECTILE = preload("res://Scenes/projectile.tscn")

var motion = Vector2()
var direction = 1

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	motion.x  = SPEED
	$AnimatedSprite.play("run")
	
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, UP)