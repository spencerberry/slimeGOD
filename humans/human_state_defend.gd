extends "res://entity_state_idea.gd"

var escape_time

var rng = RandomNumberGenerator.new()

func _ready():
	pass
	
func _init(entity).(entity):
	name = "defend"

func enter():
	entity.animation_set("walkdown")
	rng.randomize()
	escape_time = rng.randf_range(.2, .6)

func exit():
	pass
	
func update(delta):
	if not entity.sees_from("slime"):
		entity.state_set("search")
	
	entity.target = entity.closest_target("slime")
	
	if entity.target and escape_time > 0:
		entity.move_away_from(entity.target)
		entity.apply_movement(delta, 2)
		escape_time -= delta
	else:
		entity.move = Vector2(0,0);
		entity.state_set("search")