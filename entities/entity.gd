extends KinematicBody2D

signal hit

const SPEED = 0
const TYPE = "enemy"
const HIT_SAFE_TIME = 50
const VISION_RANGE = 1200
const HIT_RANGE = 200
const FOV = 180

var move = Vector2()
var attacking = false
var health = 1

var knockback_direction = Vector2()
var hit_safe = 0

func distance_to(target):
	return target.position-position

func move_towards(target):
	move = target.position-position

func apply_movement(multiplier=1):
	var move_now
	
	if hit_safe != 0:
		move_now = knockback_direction.normalized()*SPEED*2
	else:
		move_now = move.normalized()*SPEED*multiplier
		
	move_and_slide(move_now)

func tick():
	if hit_safe > 0:
		hit_safe -= 1

func choose_animation(animation):
	var newAnimation = animation
	if $Animation.current_animation != newAnimation:
		$Animation.play(newAnimation);

func take_damage_from(area):
	var body = area.get_parent()
	if hit_safe == 0 && body.get("DAMAGE") != null && body.get("TYPE") != TYPE:		
		hit_safe = HIT_SAFE_TIME
		health -= body.get("DAMAGE")
		knockback_direction = global_transform.origin - body.global_transform.origin

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
	