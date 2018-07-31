extends "res://entities/entity.gd"

const SPEED = 40

var timer_end = 300
var timer = timer_end

export (int) var sight_range

func _ready():
	choose_animation("walk")

func _physics_process(delta):
	tick()
	timer += 1
	
	if timer > timer_end:
		$Sprite.set_modulate(Color(1.0,1.0,1.0,1.0))
		timer = 0
		move.x = randf()*2-1
		move.y = randf()*2-1
		
		if move.x > 0:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
	
	if is_on_wall():
		timer = timer_end

	apply_movement()
	
	$_debug.text = str(health," ", hit_safe)
	#str(stepify(move.x,.1))+"\n"+str(stepify(move.y,.1))

func _on_hitbox_area_shape_entered(area_id, area, area_shape, self_shape):
	take_damage_from(area)