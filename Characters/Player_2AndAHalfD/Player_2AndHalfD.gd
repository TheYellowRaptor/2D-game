extends CharacterBody2D

enum Movement_states { ON_FLOOR , FALLING , JUMPING }

@onready var Shadow = get_node("/root/2,5D Testing Area/PlayableCharacter/Shadow")
@onready var tile_map = get_node("/root/2,5D Testing Area/TileMap")

@export var movement_speed := 80
@export var jump_force := -500 #Siempre debe ser negativo

var input_direction := Vector2.ZERO
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

# Lo que falta hacer ahora es:
# 	- Establecer la posición de la sombra en el suelo al estar el personaje en el aire.
# 	- Corregir el movimiento del cuerpo en comparación con el de la sombra al chocar con una pared
#	diagonal en dirección lateral.

func _physics_process(_delta):
	input_direction = Vector2 (
		Input.get_action_strength("Tecla_Derecha") - Input.get_action_strength("Tecla_Izquierda"),
		(Input.get_action_strength("Tecla_Abajo") - Input.get_action_strength("Tecla_Arriba")) * 0.8
	)
	Jump()
	if(current_state == Movement_states.ON_FLOOR):
		Shadow.position = Shadow.position.lerp(self.position, 1)
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
	shadow_position = Shadow.get_global_position()
	body_position = get_global_position()
	high_distance = (shadow_position.y - body_position.y)
	set_collision_mask_value(1, 0)
	Shadow.set_collision_mask_value(1, 1)
	if(jump_force >= 0):
		if(high_distance <= 0):
			set_collision_mask_value(1, 1)
			in_air_velocity = 0
			current_state = Movement_states.ON_FLOOR
			jump_force = -gravity * div_fac
			self.position = self.position.lerp(Shadow.position, 1)
			Shadow.set_collision_mask_value(1, 0)
		else:
			in_air_velocity = gravity #6 de más
	else:
		jump_force += gravity * in_air_time_factor
		if(in_air_velocity > 0):
			current_state = Movement_states.FALLING
#	$Velocity.text = str(floor(high_distance))
	
	var tile_on = tile_map.local_to_map(body_position)
	var cell_data = tile_map.get_cell_tile_data(0, tile_on) # Si cambio el valor de la capa salta un error
	$Velocity.text = str(cell_data.get_custom_data("wall_type"))
	if (cell_data.get_custom_data("wall_type") == "s"):
		var shadow_velocity = Shadow.velocity
		input_direction = (shadow_velocity / movement_speed)

func select_state_machine():
	pass
