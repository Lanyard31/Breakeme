extends RigidBody2D

var velocity = Vector2()
var thrown = false
var speed = 250

func _ready():
	pass

func _physics_process(delta):
	if self.thrown == true:
		pass
		#position.x += velocity * delta
		#angle()

func start(_position, _direction):
	self.thrown = true
	self.position = _position
	var rotator = Vector2(1, 0).rotated(_direction)
	self.rotation = rotator.angle()
	velocity = self.rotation * speed
	apply_impulse(Vector2(), Vector2(speed, 0))

func thrown_delete():
	queue_free()