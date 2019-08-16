extends "res://humans/human.gd"

func _ready():
	speed = 40000

#warning-ignore:unused_argument
func _physics_process(delta):
	if sees_from("players") or sees_from("tests"):
		$mood.text='!!!'
	else:
		$mood.text='???'

#warning-ignore:unused_argument
#warning-ignore:unused_argument
#warning-ignore:unused_argument
func _on_hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	take_damage_from(area)
	
func _on_Animation_animation_finished(anim_name):
	if anim_name.substr(0,5) == "swing":
		attacking = false