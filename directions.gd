extends Node

const center = Vector2(0,0)
const left 	= Vector2(-1,0)
const right = Vector2(1,0)
const up = Vector2(0,-1)
const down = Vector2(0,1)

func fromVector(vector):
	if vector == Vector2(0,0):
		return "center"
	elif vector.x < 0 and vector.x < -abs(vector.y):
		return "left"
	elif vector.x > 0 and vector.x > abs(vector.y):
		return "right"
	elif vector.y < 0:
		return "up"
	elif vector.y > 0:
		return "down"
	else:
		return "oops"