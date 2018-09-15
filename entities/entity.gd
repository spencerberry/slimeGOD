extends KinematicBody2D

const SPEED = 0
const TYPE = "enemy"
const HIT_SAFE_TIME = 20
const VISION_RANGE = 1200
const HIT_RANGE = 120
const FOV = 180

var move = Vector2()
var attacking = false
var health = 1

var knockback_direction = Vector2()
var hit_safe = HIT_SAFE_TIME

func _physics_process(delta):
	tick()

func distance_to(target):
	return target.position-position

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
	if hit_safe == 0:		
		hit_safe = HIT_SAFE_TIME
		health -= 1
		knockback_direction = global_transform.origin - body.global_transform.origin