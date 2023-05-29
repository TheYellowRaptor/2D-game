extends CharacterBody2D

@export var movement_speed := 80

var shadow_body_distance : float

func _physics_process(_delta):
	var input_direction = Vector2 (
		Input.get_action_strength("Tecla_Derecha") - Input.get_action_strength("Tecla_Izquierda"),
		(Input.get_action_strength("Tecla_Abajo") - Input.get_action_strength("Tecla_Arriba")) * 0.8
	)
	
	velocity = input_direction * movement_speed
	
	var body_position = get_node("/root/2,5D Testing Area/PlayableCharacter/PlayerBody/Sprite2D").get_global_position()
	var body_position_y = get_node("/root/2,5D Testing Area/PlayableCharacter/PlayerBody/Sprite2D").get_global_position().y
	var result = get_global_position().y - body_position_y
	var opacitty : float = (body_position_y / get_global_position().y) / 1.5
	var shadow_scale := opacitty * 1.5
	
	$CanvasLayer/Label.text = str(body_position)
	$CanvasLayer/Label2.text = str(get_global_position())
	$CanvasLayer/Label3.text = str(result)
	$CanvasLayer/Label4.text = str(opacitty)
	
	move_and_slide()
	self.modulate.a = opacitty
	self.scale = Vector2(shadow_scale,shadow_scale) # Quizás lo saque?
