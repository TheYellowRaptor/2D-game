extends CharacterBody2D

enum NPC_state { IDLE, WALKING }

@export var speed_movement : float = 20
@export var walk_min : float = 2
@export var walk_max : float = 5
@export var idle_max : float = 10

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var timer = $Timer
@onready var size = $Triceratops.scale.x

var direction_movement : Vector2
var current_state : NPC_state = NPC_state.IDLE

func _ready():
	Set_new_state()

func _physics_process(_delta):
		velocity = (speed_movement * direction_movement) * size
		move_and_slide()

func Set_Path():
	direction_movement = Vector2(
		randi_range(-1,1),
		randi_range(-1,1)
	)
	if (direction_movement != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", direction_movement)

func Set_new_state():
	if (current_state == NPC_state.IDLE):
		state_machine.travel("Walk")
		current_state = NPC_state.WALKING
		Set_Path()
		timer.start(randf_range(walk_min,walk_max))
	elif(current_state == NPC_state.WALKING):
		state_machine.travel("Idle")
		current_state = NPC_state.IDLE
		timer.start(randf_range(walk_max,idle_max))

func _on_timer_timeout():
	animation_tree.set("parameters/Idle/blend_position", direction_movement)
	direction_movement = Vector2.ZERO
	Set_new_state()
