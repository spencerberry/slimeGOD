extends "res://entity.gd"

class_name Slime

const DAMAGE = 1


#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
var IdleState = load("res://slime/states/slime_state_idle.gd")
var RollState = load("res://slime/states/slime_state_roll.gd")

func _ready():
	states = {
		idle = IdleState.new(self),
		roll = RollState.new(self)
	}
	state = states.idle
	
	speed = 48000


func _physics_process(delta):

	if hit_safe !=0:
		$SpriteBody.set_modulate(Color(1.0,1.0,1.0,randf()))
	else:
		$SpriteBody.set_modulate(Color(1.0,1.0,1.0))

	state.update(delta)

#warning-ignore:unused_argument
func _process(delta):
	input_direction()
	$_debug.text = str(knockback_direction)
	
func input_direction():	
	var left 	= Input.is_action_pressed("p1_left")
	var right 	= Input.is_action_pressed("p1_right")
	var up 		= Input.is_action_pressed("p1_up")
	var down 	= Input.is_action_pressed("p1_down")
	
	move.x = -int(left) + int(right)
	move.y = -int(up) + int(down)
	return ( move.x + move.y == 0)
	
func attack():
	attacking = true

func animation_over(anim_name):
	if anim_name == "attack":
		attacking = false

#warning-ignore:unused_argument
#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_hurtbox_area_shape_entered(area_id, area, area_shape, self_shape):
	take_damage_from(area)

func animation_flip(boolean):
	$SpriteBody.flip_h = boolean
	$SpriteBody/SpriteFace.flip_h = boolean
	$SpriteBody/SpriteSoul.flip_h = boolean

