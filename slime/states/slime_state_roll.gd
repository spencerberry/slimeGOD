extends "res://entity_state_idea.gd"

func _ready():
	pass
	
func _init(entity).(entity):
	name = "roll"
	
func enter():
	entity.animation_set("rollright")

func exit():
	pass

func update(delta):
	if entity.move == Vector2(0,0):
		entity.state_set("idle")
	elif entity.move.x < 0:
		entity.animation_flip(true)
	elif entity.move.x > 0:
		entity.animation_flip(false)
	entity.apply_movement(delta)


