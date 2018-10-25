extends KinematicBody2D

var gravityfactor = 200.0
var WALK_SPEED = 400
var swim_speed = 200
var swim_factor_x = 0
var gravity = false
var velocity = Vector2()
var on_ground = false
var slide_stop_x = false
var no_input_x = false


func _ready():
	pass

func _process(delta):
	if gravity == false:
		if on_ground == false:
			#Floaty Zero-G swim logic
			#the just released thing doesn't work on more than 1 because you have to press it again
			#if Input.is_action_pressed("ui_left"):
			#	no_input_x = false
			if Input.is_action_just_pressed("ui_left"):
				#$Bodysprite.play("swim")
				slide_stop_x = false
				no_input_x = false
				$Timers/no_input_x.stop()
				if swim_factor_x <= 0 and swim_factor_x >= -2:
					swim_factor_x -= 1
				#cancel rightwards movement
				if swim_factor_x > 0:
					swim_factor_x = lerp(swim_factor_x, 0.0, 1)
				velocity.x = (swim_speed * swim_factor_x)
			if Input.is_action_just_released("ui_left"):
				$Timers/no_input_x.start()
				if no_input_x == true:
					$Timers/swim_timer_x.start()

			#if Input.is_action_pressed("ui_right"):
			#	no_input_x = false
			if Input.is_action_just_pressed("ui_right"):
				#$Bodysprite.play("swim")
				slide_stop_x = false
				no_input_x = false
				$Timers/no_input_x.stop()
				if swim_factor_x >= 0 and swim_factor_x <= 2:
					swim_factor_x += 1
				#cancel leftwards movement
				if swim_factor_x < 0:
					swim_factor_x = lerp(swim_factor_x, 0.0, 1)
				velocity.x = (swim_speed * swim_factor_x)
			if Input.is_action_just_released("ui_right"):
				$Timers/no_input_x.start()
				if no_input_x == true:
					$Timers/swim_timer_x.start()
			#This implementation did not work
			#if no_input_x == true:
			#	$Timers/swim_timer_x.start()
				
				
			#elif Input.is_action_pressed("ui_up"):
				#velocity.y =  WALK_SPEED
			#elif Input.is_action_pressed("ui_down"):
				#velocity.y =  WALK_SPEED

			if slide_stop_x == true:
				velocity.x = lerp(velocity.x, 0.0, 0.05)
				
				
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
