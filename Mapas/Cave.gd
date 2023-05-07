extends Node2D

@onready var Light_trap = preload("res://Characters/Lightrap/Light_trap.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for n in 1:
		create_lights_in_cuadrant(Vector2(
			randi_range(-75,0),
			randi_range(0,75)
		))

	for n in 1:
		create_lights_in_cuadrant(Vector2(
			randi_range(0,75),
			randi_range(0,75)
		))

	for n in 1:
		create_lights_in_cuadrant(Vector2(
			randi_range(-75,0),
			randi_range(75,150)
		))

	for n in 1:
		create_lights_in_cuadrant(Vector2(
			randi_range(0,75),
			randi_range(75,150)
		))


func create_lights_in_cuadrant(cuadrant):
	var random_position = cuadrant
	var light_trap = Light_trap.instantiate()
	light_trap.position = random_position
	self.add_child(light_trap)
