extends "res://entity.gd"

#warning-ignore:unused_class_variable
var target #used in states

var enemies = "horde"

const VISION_RANGE = 1200
const HIT_RANGE = 200
const FOLLOW_RANGE = 200

const FOV = 180

var master = null

#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable
#warning-ignore:unused_class_variable

func _ready():
	become_autonomous()

func _process(delta):
	if is_in_group("horde"):
		become_minion()
		
	state.update(delta)
	
	$_debug.text = state.name
	if master:
		$_debug/status.text = master.name
		
func move_towards(goal):
	move = distance_to(goal)

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

func become_minion():
	var FollowState = load ("res://humans/human_state_follow.gd")
	var PursueState = load ("res://humans/human_state_pursue.gd")
	var AttackState = load ("res://humans/human_state_attack.gd")
	
	$SpriteBody.set_modulate(Color(0.4,0.4,1.0))
	
	states = {
		follow = FollowState.new(self),
		pursue = PursueState.new(self),
		attack = AttackState.new(self)
	}
	
	state_set("follow")
	master = get_tree().get_nodes_in_group("slime")[0]
	enemies = "human"

func become_autonomous():
	var WanderState = load ("res://humans/human_state_wander.gd")
	var PursueState = load ("res://humans/human_state_pursue.gd")
	var SearchState = load ("res://humans/human_state_search.gd")
	var DefendState = load ("res://humans/human_state_defend.gd")
	var AttackState = load ("res://humans/human_state_attack.gd")

	states = {
		wander = WanderState.new(self),
		pursue = PursueState.new(self),
		search = SearchState.new(self),
		defend = DefendState.new(self),
		attack = AttackState.new(self),
	}
	state = states.wander


	