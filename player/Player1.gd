extends KinematicBody2D

export (float) var max_speed 	#pixels per second
#export (float) var acceleration #pps per second
#export (float) var friction

var velocity = Vector2()
var direction = Vector2()

var attacking = false

func _ready():
	pass

func _physics_process(delta):
	var move = input_move()
	var attack = Input.is_action_pressed("p1_attack")
	
	direction = move
	apply_movement(move)
	
	$_debug.text = str(direction)

func input_move():
	var move = Vector2()
	
	var left 	= Input.is_action_pressed("p1_left")
	var right 	= Input.is_action_pressed("p1_right")
	var up 		= Input.is_action_pressed("p1_up")
	var down 	= Input.is_action_pressed("p1_down")
	
	move.x = -int(left) + int(right)
	move.y = -int(up) + int(down)

	return move

func apply_movement(move):
	velocity = move.normalized()*max_speed
	move_and_slide(velocity, Vector2(0,0))
			
func choose_animation(animation):
	var newAnimation = animation
	if $Animation.current_animation != newAnimation:
		$Animation.play(newAnimation);