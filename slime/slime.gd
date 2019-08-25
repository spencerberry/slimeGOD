extends "res://entity.gd"

const DAMAGE = 1

var aura = Color(.2, .2, .2, .2)

var input_mouse = Vector2()

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

func _input(event):
	if event is InputEventMouseMotion:
		input_mouse = event.get_relative()

#warning-ignore:unused_argument
func _physics_process(delta):
	pass
	
func _process(delta):
	input_direction()

	if hit_safe !=0:
		$SpriteBody.set_modulate(Color(1.0,1.0,1.0,randf()))
	else:
		$SpriteBody.set_modulate(Color(1.0,1.0,1.0))

	state.update(delta)
	
	$_debug.text = str($aura.get_position())
	
	var new_aura_position = $aura.get_position() + input_mouse
	
	new_aura_position.x = clamp(new_aura_position.x, -200, 200)
	new_aura_position.y = clamp(new_aura_position.y, -200, 200)
	
	$aura.set_position(new_aura_position)
	print(new_aura_position)
	update()
	
func _draw():
	draw_circle($aura.get_global_position(), $aura/CollisionShape2D.get_shape().radius, aura)

	
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

