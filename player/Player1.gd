extends "res://entities/entity.gd"

const SPEED = 600
const TYPE = "player"
const DAMAGE = 1

func _ready():
	pass

func _physics_process(delta):
	$_debug.text = str(stepify(position.x,.1)) #+ " " + str(stepify(position.y,.1))
	$_debugRect.rect_position=Vector2(10,10)

func input_move():	
	var left 	= Input.is_action_pressed("p1_left")
	var right 	= Input.is_action_pressed("p1_right")
	var up 		= Input.is_action_pressed("p1_up")
	var down 	= Input.is_action_pressed("p1_down")
	
	move.x = -int(left) + int(right)
	move.y = -int(up) + int(down)
	
func attack():
	attacking = true

func attack_over(anim_name):
	if anim_name == "attack":
		attacking = false