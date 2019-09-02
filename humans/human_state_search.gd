extends "res://entity_state_idea.gd"

const SEARCH_TIME = 8
var searching_for = SEARCH_TIME

func _ready():
	pass
	
func _init(entity).(entity):
	name = "search"

func enter():
	entity.animation_set("idlesway")
	searching_for = SEARCH_TIME

func exit():
	pass
	
func update(delta):
	
	searching_for -= delta
	if entity.sees_from(entity.enemies):
		entity.state_set("pursue")
	elif searching_for < 0:
		entity.state_set("wander")