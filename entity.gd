extends KinematicBody2D

var speed = 100

const HIT_SAFE_TIME = 1.2
const KNOCKBACK_TIME = .4

var move = Vector2()

#warning-ignore:unused_class_variable
var attacking = false #used in humans, to be used in slime
var health = 1

var knockback_direction = Vector2()

var hit_safe = 0

var states = null
var state = null

func _process(delta):
	tick(delta)
	
func distance_to(target):
	return target.position-position

func apply_movement(delta, multiplier=1):
	var move_now

	if hit_safe > HIT_SAFE_TIME-KNOCKBACK_TIME:
		move_now = knockback_direction*speed*delta*2
	else:
		move_now = move.normalized()*speed*delta*multiplier
	#warning-ignore:return_value_discarded
	move_and_slide(move_now)

func tick(delta):
	if hit_safe > 0:
		hit_safe -= delta
	else:
		hit_safe = 0
		knockback_direction = Vector2(0,0)

#new animation switcher
func animation_set(action):
#	sprite_direction = direction.fromVector(move)
#	var newAnimation = str(action,sprite_direction)
	if $Animation.current_animation != action:
		$Animation.play(action)

func take_damage_from(area):
	var body = area.get_parent()
	if hit_safe == 0 and area.name == "hitbox":		
		hit_safe = HIT_SAFE_TIME
		health -= 1
		knockback_direction = (global_transform.origin - body.global_transform.origin).normalized()

# STATE #
func state_set(new_state):
	if states[new_state]:
		state.exit()
		state = states[new_state]
		state.enter()
	else:
		print("called non-existant state")