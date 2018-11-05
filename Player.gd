extends KinematicBody2D

signal thrownenemy

var gravityfactor = 200.0
var WALK_SPEED = 400
var swim_speed = 400
var swim_factor_x = 0
var swim_factor_y = 0
var gravity = false
var velocity = Vector2()
var on_ground = false
var slide_stop_x = false
var no_input_x = false
var grabbing = false
var grabbed = false
var throwing = false
var rotation_factor = 0.1


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("Z"):
		if grabbed == true:
			throwing = true
		else:
			grabbing = true
	
	if gravity == false:
		if on_ground == false:
			if grabbed == false:
				#Floaty Zero-G swim logic
				
				#these are the brakes
				
				var initial_velfloatx = float(velocity.x)
				var initial_velfloaty = float(velocity.y)
				velocity.x = lerp(initial_velfloatx, 0.0, 0.02)
				velocity.y = lerp(initial_velfloaty, 0.0, 0.02)
				
				#if Input.is_action_just_released("ui_right"):
				#	velocity.y = lerp(initial_velfloaty, 0.0, 0.1) 
				
				#the just released thing wasn't working on more than 1 because you have to release to press it again
				
				#if Input.is_action_pressed("ui_right"):
				#	no_input_x = false
				if Input.is_action_just_pressed("ui_right"):
					#$Bodysprite.play("swim")
					#slide_stop_x = false
					#no_input_x = false
					#$Timers/no_input_x.stop()
					if swim_factor_x >= 1 and swim_factor_x < 2:
						swim_factor_x += 1
					if swim_factor_x >= 0 and swim_factor_x < 1:
						swim_factor_x += 1
					#cancel leftwards movement
					if swim_factor_x < 0:
						swim_factor_x = 0
						#swim_factor_x = lerp(swim_factor_x, 0.0, 1)
					var velfloatx = float(velocity.x)
					velocity.x = lerp(velfloatx, float(swim_speed * swim_factor_x), 0.5)
					#was formerly
					#velocity.x = (swim_speed * swim_factor_x)
				#if Input.is_action_just_released("ui_right"):
				#	$Timers/no_input_x.start()
				#	if no_input_x == true:
				#		$Timers/swim_timer_x.start()
				
				#if Input.is_action_pressed("ui_left"):
				#	no_input_x = false
				
				if Input.is_action_just_pressed("ui_left"):
					if swim_factor_x <= -1 and swim_factor_x > -2:
						swim_factor_x -= 1
					if swim_factor_x <= 0 and swim_factor_x > -1:
						swim_factor_x -= 1
					#cancel rightwards movement
					if swim_factor_x > 0:
						swim_factor_x = lerp(swim_factor_x, 0.0, 1)
					var velfloatx = float(velocity.x)
					velocity.x = lerp(velfloatx, float(swim_speed * swim_factor_x), 0.5)
					
				if Input.is_action_just_pressed("ui_up"):
					if swim_factor_y <= -1 and swim_factor_y > -2:
						swim_factor_y -= 1
					if swim_factor_y <= 0 and swim_factor_y > -1:
						swim_factor_y -= 1
					#cancel rightwards movement
					if swim_factor_y > 0:
						swim_factor_y = lerp(swim_factor_y, 0.0, 1)
					var velfloaty = float(velocity.y)
					velocity.y = lerp(velfloaty, float(swim_speed * swim_factor_y), 0.5)
	
				if Input.is_action_just_pressed("ui_down"):
					if swim_factor_y >= 1 and swim_factor_y < 2:
						swim_factor_y += 1
					if swim_factor_y >= 0 and swim_factor_y < 1:
						swim_factor_y += 1
					#cancel leftwards movement
					if swim_factor_y < 0:
						swim_factor_y = lerp(swim_factor_y, 0.0, 1)
					var velfloaty = float(velocity.y)
					velocity.y = lerp(velfloaty, float(swim_speed * swim_factor_y), 0.5)
					#$Bodysprite.play("swim")
	#				slide_stop_x = false
	#				no_input_x = false
	#				$Timers/no_input_x.stop()
	#				if swim_factor_x <= 0 and swim_factor_x >= -2:
	#					swim_factor_x -= 1
					#cancel rightwards movement
	#				if swim_factor_x > 0:
	#					swim_factor_x = lerp(swim_factor_x, 0.0, 1)
	#				velocity.x = (swim_speed * swim_factor_x)
	#			if Input.is_action_just_released("ui_left"):
	#				$Timers/no_input_x.start()
	#				if no_input_x == true:
	#					$Timers/swim_timer_x.start()
				#This implementation did not work
				#if no_input_x == true:
				#	$Timers/swim_timer_x.start()
					
					
				#elif Input.is_action_pressed("ui_up"):
					#velocity.y =  WALK_SPEED
				#elif Input.is_action_pressed("ui_down"):
					#velocity.y =  WALK_SPEED
	
				if slide_stop_x == true:
					velocity.x = lerp(velocity.x, 0.0, 0.05)
#end zero_G movement code
#grab rotate code
	if gravity == false:
		if on_ground == false:
			if grabbed == true:
				if Input.is_action_pressed("ui_right"):
					self.rotation += rotation_factor
				if Input.is_action_pressed("ui_left"):
					self.rotation -= rotation_factor


			#else:
				#globalplayer.globalgrab = false
					
	#Gravity Code
	if gravity == true:
		velocity.y += delta * gravityfactor
		if Input.is_action_pressed("ui_left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			velocity.x =  WALK_SPEED
		else:
			velocity.x = 0
		move_and_slide(velocity, Vector2(0, -1))
		
		
				
func _physics_process(delta):
	move_and_slide(velocity, Vector2(0, 0))
	throw()
	#grabcode
	for i in range(get_slide_count() - 1):
			var collision = get_slide_collision(i)
			if collision.collider.is_in_group("enemy"):
				#print(collision.collider.name)
				#throw(collision.collider)
				grab(collision.collider)
				#collision.collider.queue_free()
				
				
func throw():
	if throwing == true:
		throwing = false
		grabbed = false
		$Bodysprite.play("idle")
		globalplayer.globalgrabbedenemy = ("enemyinstance")
		for i in range(0, get_child_count()):
			get_child(i)
			#print(get_child(i))
			if get_child(i).has_method("thrown_delete"):
				#print(get_child(i))
				var enemyname = get_child(i).get_name()
				get_child(i).thrown_delete()
				emit_signal("thrownenemy", enemyname, $grabpoint.global_position, self.rotation)
		self.rotation = 0
				
		#collider.queue_free()

func grab(collider):
	if grabbing == true:
		grabbing = false
		grabbed = true
		$Bodysprite.play("grab")
		var grabbedenemy = load("res://Enemy.tscn")
		var enemyinstance = grabbedenemy.instance()
		#enemyinstance.set_name("enemyinstance")
		globalplayer.globalgrabbedenemy = ("enemyinstance")
		collider.queue_free()
		add_child(enemyinstance)
		enemyinstance.global_position = $grabpoint.global_position
		velocity.x = 0
		velocity.y = 0

	
	#make new but grabbed
	#rotation effect
	
	pass
	
	

# We don't need to multiply velocity by delta because MoveAndSlide already takes delta time into account.
# The second parameter of move_and_slide is the normal pointing up.
# In the case of a 2d platformer, in Godot upward is negative y, which translates to -1 as a normal.
	#move_and_slide(velocity, Vector2(0, -1))

func _on_Swipesprite_animation_finished():
	#attack code here later
	pass

func _on_no_input_x_timeout():
	no_input_x = true

func _on_swim_timer_x_timeout():
	slide_stop_x = true
	swim_factor_x = 0
	#$Bodysprite.play("idle")
	
func _on_no_input_y_timeout():
	pass # replace with function body
	
func _on_swim_timer_y_timeout():
	pass # replace with function body
