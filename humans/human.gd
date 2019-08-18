extends "res://entity.gd"

#warning-ignore:unused_class_variable
var target #used in states

const VISION_RANGE = 1200
const HIT_RANGE = 160

const FOV = 180

#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable

var WanderState = load ("res://humans/human_state_wander.gd")
var PursueState = load ("res://humans/human_state_pursue.gd")
var SearchState = load ("res://humans/human_state_search.gd")
var DefendState = load ("res://humans/human_state_defend.gd")
var AttackState = load ("res://humans/human_state_attack.gd")
var HordeState = load("res://humans/human_state_horde.gd")

var searching_for = Timer.new()

func _ready():
	states = {
		wander = WanderState.new(self),
		pursue = PursueState.new(self),
		search = SearchState.new(self),
		defend = DefendState.new(self),
		attack = AttackState.new(self),
		horde = HordeState.new(self)
	}
	state = states.wander

	add_child(searching_for)
	
func _process(delta):
	if is_in_group("horde"):
		$SpriteBody.set_modulate(Color(0.4,0.4,1.0))
		state_set("horde")
	state.update(delta)
	$_debug.text = state.name
	$_debug/status.text = str(searching_for.get_time_left())
	
func move_towards(target):
	move = distance_to(target)

func move_away_from(target):
	move = -distance_to(target)

func closest_target(group):
	var range_so_far = VISION_RANGE
	if sees_from(group):
		var target_so_far 
		for target in get_tree().get_nodes_in_group(group):
			var self_to_target = distance_to(target)
			if self_to_target.length() < range_so_far:
				range_so_far = self_to_target.length()
				target_so_far=target
		return target_so_far
	return false

func sees_from(group):
	var targets = get_tree().get_nodes_in_group(group)
	for target in targets:
		if sees(target):
			return true
	return false
	
func sees(target):
	var self_to_target = distance_to(target)
	$Vision.cast_to = self_to_target-$Vision.position

	if self_to_target.length() < VISION_RANGE:
		if $Vision.is_colliding():
			if $Vision.get_collider() == target:
				return true
	return false

func join_the_horde():
	pass

	