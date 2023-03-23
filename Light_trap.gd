extends StaticBody2D

enum NPC_state { EMERGED, HIDED, HIDING, EATING }

#@export var sensibility : float = 100
@onready var Detect_region = $Area2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var current_state : NPC_state = NPC_state.EMERGED

func _ready():
	var cerato_area = get_node("../CeratoPlayer/Area2D")
	var lightrap_area = get_node("Area2D")
	
	cerato_area.area_entered.connect(_on_area_2d_area_entered)
	cerato_area.area_exited.connect(_on_area_2d_area_exited)

func _process(delta):
	pass
#	select_animation()

#func hide():
#	if ()

#func select_animation():
#	if (current_state == NPC_state.EMERGED):
#		state_machine.travel("Idle_moving")

func _on_area_2d_area_entered(area):
	if (current_state == NPC_state.EMERGED):
		state_machine.travel("Hide")
		current_state = NPC_state.HIDED
	if (current_state == NPC_state.HIDED):
		state_machine.travel("Idle_hide")
#	pass # Replace with function body.

func _on_area_2d_area_exited(area):
	if(current_state == NPC_state.HIDED):
		state_machine.travel("Show_up")
		current_state = NPC_state.EMERGED
