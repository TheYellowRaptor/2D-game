extends CharacterBody2D

enum Movement_states { ON_FLOOR , FALLING , JUMPING }

@export var movement_speed := 80
@export var jump_force := -500 #Cuidar que la sombra no quede desfasada 400

var current_state := Movement_states.ON_FLOOR
var div_fac := 2
var gravity := -jump_force / div_fac
var in_air_time_factor := 0.05
var in_air_velocity := 0
var shadow_position := Vector2.ZERO
var body_position := Vector2.ZERO
var high_distance := 0

func _ready():
	pass

func _physics_process(_delta):
	var shadow_position = get_node("/root/2,5D Testing Area/PlayableCharacter/Shadow").get_global_position()
	var body_position = get_global_position()
	var high_distance = (shadow_position.y - body_position.y)
	$Velocity.text = str(in_air_velocity)
	var input_direction = Vector2 (
		Input.get_action_strength("Tecla_Derecha") - Input.get_action_strength("Tecla_Izquierda"),
		(Input.get_action_strength("Tecla_Abajo") - Input.get_action_strength("Tecla_Arriba")) * 0.8
	)
	Jump()
	if(current_state == Movement_states.ON_FLOOR):
		get_node("/root/2,5D Testing Area/PlayableCharacter/Shadow").position = get_node("/root/2,5D Testing Area/PlayableCharacter/Shadow").position.lerp(self.position, 1)
		in_air_velocity = 0
	else:
		in_air_velocity = jump_force + gravity
		_test()
	velocity.x = input_direction.x * movement_speed
	velocity.y = input_direction.y * movement_speed + in_air_velocity
	move_and_slide()
	select_state_machine()

func Jump():
	if Input.is_action_just_pressed("Jump"):
		if(current_state == Movement_states.ON_FLOOR):
			current_state = Movement_states.JUMPING

func _test():
#	if(in_air_velocity >= gravity):
	if(jump_force >= 0):
		if(high_distance >= 0):
			in_air_velocity = 0
			current_state = Movement_states.ON_FLOOR
			jump_force = -gravity * div_fac
			self.position = self.position.lerp(get_node("/root/2,5D Testing Area/PlayableCharacter/Shadow").position, 1)
		else:
			in_air_velocity = gravity #6 de más
	else:
		jump_force += gravity * in_air_time_factor
		if(in_air_velocity > 0):
			current_state = Movement_states.FALLING

func select_state_machine():
	pass
