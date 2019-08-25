extends "res://entity_state_idea.gd"

func _ready():
	pass
	
func _init(entity).(entity):
	name = "follow"

func enter():
	entity.animation_set("walkdown")

func exit():
	pass

func update(delta):
	#entity.target = entity.closest_target("human")

	if entity.distance_to(entity.master).length() > entity.FOLLOW_RANGE and entity.sees(entity.master):
		entity.move_towards(entity.master)
		entity.apply_movement(delta)
	else:
		entity.animation_set("idlesway")