extends Node2D

const FOLLOW_SPEED = 2.0

func _physics_process(delta):
	var mouse_position = get_local_mouse_position()
	
	$Cave_moth.position = $Cave_moth.position.lerp(mouse_position, delta * FOLLOW_SPEED)

