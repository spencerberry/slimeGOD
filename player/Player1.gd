extends "res://entities/entity.gd"

const SPEED = 600
const DAMAGE = 1

var hopping = false

var pulse_timer = 0
var pulse_length = 60
var first_color = Color(.5,.5,1,.6)
var second_color = Color(.2,.2,1,.6)
var goal_color = first_color

func _ready():
	pass

func _physics_process(delta):
	$_debug.text = str(stepify(position.x,.1)) #+ " " + str(stepify(position.y,.1))
	$_debugRect.rect_position=Vector2(10,10)
	
#	pulse_timer += 1
#
#	if pulse_timer == pulse_length:
#		pulse_timer = 0
#		if goal_color == first_color:
#			goal_color = second_color
#		else:
#			goal_color = first_color
#	var step_color = goal_color/pulse_length
#	if goal_color.gray() > $"SpriteBody/SpriteSoul".modulate.gray():
#		$"SpriteBody/SpriteSoul".modulate+=step_color
#	else:
#		$"SpriteBody/SpriteSoul".modulate-=step_color
		
	

func input_move():	
	var left 	= Input.is_action_pressed("p1_left")
	var right = Input.is_action_pressed("p1_right")
	var up 		= Input.is_action_pressed("p1_up")
	var down 	= Input.is_action_pressed("p1_down")
	
	move.x = -int(left) + int(right)
	move.y = -int(up) + int(down)
	
func attack():
	attacking = true

func animation_over(anim_name):
	if anim_name == "attack":
		attacking = false
	elif anim_name == "hopup":
		hopping = false