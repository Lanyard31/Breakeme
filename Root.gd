extends Node

#What's up dude
#I'm not afraid to die

func _ready():
	pass

func _on_NoGravitySwimmer_pressed():
	get_tree().change_scene("res://Level1.tscn")

func _on_Gravity_pressed():
	get_tree().change_scene("res://Level1.tscn")
