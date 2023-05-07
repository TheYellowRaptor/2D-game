extends CharacterBody2D

enum NPC_state { WANDERING, ATTRACTED, FLEE, TRAPPED }

@onready var timer = $Change_direction

var speed_movement : float = 32
var direction_movement : Vector2
var current_state : NPC_state = NPC_state.WANDERING
var Light_trap_position : Vector2

func _ready():
	pass

func _physics_process(_delta):
		velocity = speed_movement * direction_movement
		move_and_slide()

func Set_Path():
	if(current_state == NPC_state.WANDERING):
		direction_movement += Vector2(
			randf_range(-1,1),
			randf_range(-1,1)
		)
		timer.start(randf_range(0,0.5))
	if(current_state == NPC_state.ATTRACTED):
		var x_res = (Light_trap_position.x - self.position.x)
		var y_res = (Light_trap_position.y - self.position.y)
		if(abs(x_res) > abs(y_res)):
			direction_movement += Vector2(
			((x_res/abs(x_res))/(randf_range(2, 2.5)) + (randf_range(-0.5,0.5))),
			((y_res/abs(x_res))/(randf_range(2, 2.5)) + (randf_range(-0.5,0.5)))
			)
		if(abs(x_res) < abs(y_res)):
			direction_movement += Vector2(
			((x_res/abs(y_res))/(randf_range(2, 2.5)) + (randf_range(-0.5,0.5))),
			((y_res/abs(y_res))/(randf_range(2, 2.5)) + (randf_range(-0.5,0.5)))
			)
		timer.start(randf_range(0.5,1))

func Stop():
	direction_movement = Vector2.ZERO
	timer.start(randf_range(0,0.001))

func _on_change_direction_timeout():
	if (direction_movement != Vector2.ZERO):
		Stop()
	else:
		Set_Path()
