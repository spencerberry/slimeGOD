extends "res://entities/entity.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func move_towards(target):
	move = distance_to(target)

func closest_target(group):
	var range_so_far = VISION_RANGE
	if sees_from(group):
		var target_so_far 
		for target in get_tree().get_nodes_in_group(group):
			var self_to_target = distance_to(target)
			if self_to_target.length() < range_so_far:
				range_so_far = self_to_target.length()
				target_so_far=target
		return target_so_far
	return false

func sees_from(group):
	var targets = get_tree().get_nodes_in_group(group)
	for target in targets:
		if sees(target):
			return true
	return false
	
func sees(target):
	var self_to_target = distance_to(target)
	$Vision.cast_to = self_to_target-$Vision.position

	if self_to_target.length() < VISION_RANGE:
		if $Vision.is_colliding():
			if $Vision.get_collider() == target:
				return true
	return false
	