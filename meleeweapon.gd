extends Area2D

signal attack_finished

onready var animation_player = $AnimationPlayer

enum STATES {IDLE, ATTACK}
var current_state = IDLE

export(int) var damage = 1

func _ready():
	set_physics_process(false)
	
func attack():
	#called from character, when stat switches to ATTACK
	pass

func _change_state(new_state):
	current_state = new_state
	
func _physics_process(delta):
	pass