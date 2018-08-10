extends "res://entities/entity.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here

	pass

func _physics_process(delta):
	$Vision.cast_to=to_local($"/root/Game/Player1".global_position)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
