extends Node

var entity = null

func _ready():
	pass # Replace with function body.

func _init(entity):
	self.entity = entity
	
#warning-ignore:unused_argument
func input(event):
	assert(false)
func enter():
	assert(false)
func exit():
	assert(false)
	
#warning-ignore:unused_argument
func update(delta):
	assert(false)
