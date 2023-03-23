extends CharacterBody2D

@export var velocidad_movimiento : float = 100
@export var direccion_inicial : Vector2

@onready var arbol_animacion = $AnimationTree
@onready var state_machine = arbol_animacion.get("parameters/playback")

func _ready():
	actualizar_parametros_animacion(direccion_inicial)

func _physics_process(_delta):
	var input_direction = Vector2(
		Input.get_action_strength("Tecla_Derecha") - Input.get_action_strength("Tecla_Izquierda"),
		Input.get_action_strength("Tecla_Abajo") - Input.get_action_strength("Tecla_Arriba")
	)
	actualizar_parametros_animacion(input_direction)
	velocity = input_direction * velocidad_movimiento
	move_and_slide()
	seleccionar_nuevo_estado()

func actualizar_parametros_animacion(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		arbol_animacion.set("parameters/Caminar/blend_position", move_input)
		arbol_animacion.set("parameters/Espera/blend_position", move_input)

func seleccionar_nuevo_estado():
	if (velocity != Vector2.ZERO):
		state_machine.travel("Caminar")
	else:
		state_machine.travel("Espera")
