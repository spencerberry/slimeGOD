extends "res://entity_state_idea.gd"

var rng = RandomNumberGenerator.new()

func _ready():
	pass
	
func _init(entity).(entity):
	name = "attack"

func enter():
	entity.animation_set("swingdown")
	entity.attacking = true

func exit():
	pass

#warning-ignore:unused_argument
func update(delta):

	if not entity.sees_from("slime"):
		entity.state_set("search")
		
	elif not entity.attacking:
		
		var roll = rng.randi_range(1,10)
		if roll == 10:
			entity.state_set("pursue")
		else:
			entity.state_set("defend")


