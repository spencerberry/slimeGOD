extends KinematicBody2D

signal hit

const SPEED = 0
const TYPE = "enemy"
const HIT_SAFE_TIME = 50

var move = Vector2()
var health = 1

var knockback_direction = Vector2()
var hit_safe = 0


func _ready():
	pass

func apply_movement():
	var move_now
	
	if hit_safe != 0:
		move_now = knockback_direction.normalized()*SPEED*2
	else:
		move_now = move.normalized()*SPEED
		
	move_and_slide(move_now, Vector2(0,0))

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