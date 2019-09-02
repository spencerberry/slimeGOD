extends "res://entity_state_idea.gd"

func _ready():
	pass
	
func _init(entity).(entity):
	name = "pursue"

func enter():
	entity.animation_set("walkdown")

func exit():
	pass

func update(delta):
	entity.target = entity.closest_target(entity.enemies)
	
	if not entity.target or not entity.sees(entity.target):
		entity.state_set("search")

	if entity.target and entity.distance_to(entity.target).length() < entity.HIT_RANGE:
		entity.state_set("attack")
	elif entity.target:
		entity.move_towards(entity.target)
		entity.apply_movement(delta)
#	else:
#		entity.move = Vector2(0,0);
#		entity.state_set("search")