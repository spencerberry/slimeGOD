extends "res://entity_state_idea.gd"

func _ready():

	pass
func _init(entity).(entity):
	name = "idle"

func enter():
	entity.animation_set("idle")

func exit():
	pass
	
#warning-ignore:unused_argument
func update(delta):
	if entity.move:
		entity.state_set("roll")