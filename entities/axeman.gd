extends "res://entities/human.gd"

const SPEED = 300

var count = 0

var target

func _ready():
	pass

func _physics_process(delta):
	if sees_from("players") or sees_from("tests"):
		$mood.text='!!!'
	else:
		$mood.text='???'
	apply_movement()

	$_debug.text=$FSM2D.currentStateID


func _on_hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	take_damage_from(area)
	
func _on_Animation_animation_finished(anim_name):
	attacking = false