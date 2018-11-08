extends RigidBody2D

var velocity = Vector2()
var thrown = false
var speed = 250
var currentlygrabbed = false
var grabposition = Vector2()
var rotator

func _ready():
	pass
	
func imgrabbed(grabposition):
	self.position = grabposition
	currentlygrabbed = true
	print(grabposition)
	
func _process(delta):
	pass
	#if currentlygrabbed == true:
	#	self.global_position = grabposition

func _physics_process(delta):
	if self.thrown == true:
		pass
		#position.x += velocity * delta
		#angle()

#only used for grabtargets with faces
func grabface():
	$face.play("grabbed")

func thrown(_position, _direction):
	self.thrown = true
	self.position = _position
	rotator = Vector2(1, 0).rotated(_direction)
	self.rotation = rotator.angle()
	velocity = self.rotation * speed
	apply_impulse(Vector2(), Vector2(velocity, 0))

func thrown_delete():
	queue_free()