extends "res://entity_state_idea.gd"

func _ready():
	pass
	
func _init(entity).(entity):
	name = "horde"

func enter():
	entity.animation_set("idlesway")

func exit():
	pass

#warning-ignore:unused_argument
func update(delta):
	if entity.sees_from("humans"):
		entity.state_set("pursue")