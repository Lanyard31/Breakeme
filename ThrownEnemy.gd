extends "res://Enemy.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
		global_position.x += 5

#this node is not currently used for anything except establishing the Thrown group