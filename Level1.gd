extends Node


func _ready():
	pass

func thrownenemy(enemyname, _position, _direction):
	var enemyresource = str("res://" + str(enemyname) + ".tscn")
	var enemyscene = load(enemyresource)
	var e = enemyscene.instance()
	add_child(e)
	e.start(_position, _direction)