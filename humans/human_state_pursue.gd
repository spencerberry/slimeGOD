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
	if not entity.sees_from("slime"):
		entity.state_set("search")
		
	entity.target = entity.closest_target("slime")
	
	if entity.target and entity.distance_to(entity.target).length() < entity.HIT_RANGE:
		entity.state_set("attack")
	elif entity.target:
		entity.move_towards(entity.target)
		entity.apply_movement(delta)
#	else:
#		entity.move = Vector2(0,0);
#		entity.state_set("search")