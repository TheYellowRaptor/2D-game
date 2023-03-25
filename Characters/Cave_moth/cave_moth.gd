extends CharacterBody2D

@onready var timer = $Change_direction

var speed_movement : float = 32
var direction_movement : Vector2

func _ready():
	pass

func _physics_process(_delta):
		velocity = speed_movement * direction_movement
		move_and_slide()

func Set_Path():
	direction_movement += Vector2(
		randf_range(-1,1),
		randf_range(-1,1)
	)
	timer.start(randf_range(0,0.5))

func Stop():
	direction_movement = Vector2.ZERO
	timer.start(randf_range(0,0.001))

func _on_change_direction_timeout():
	if (direction_movement != Vector2.ZERO):
		Stop()
	else:
		Set_Path()
