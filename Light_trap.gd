extends StaticBody2D

enum NPC_state { EMERGED, HIDED, HIDING, EATING }

#@export var sensibility : float = 100
@onready var Detect_region = $Area2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var current_state : NPC_state = NPC_state.EMERGED

func _on_area_2d_body_entered(body):
	if(body.name == "CeratoPlayer"):
		if (current_state == NPC_state.EMERGED):
			state_machine.travel("Hide")
			current_state = NPC_state.HIDED
		if (current_state == NPC_state.HIDED):
			state_machine.travel("Idle_hide")
	#	pass # Replace with function body.

func _on_area_2d_body_exited(body):
	if(body.name == "CeratoPlayer"):
		if(current_state == NPC_state.HIDED):
			state_machine.travel("Show_up")
			current_state = NPC_state.EMERGED
