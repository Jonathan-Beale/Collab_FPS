extends KinematicBody

export var speed = 10
export var acceleration = 20
export var gravity = 10
export var jump = 7
export var mouse_sensitivity = 0.2
var mouse_locked
var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var head = $Head
# Called when the node enters the scene tree for the first time.
func _ready():
	#locks the mouse to the screen and makes it invisible
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_locked = true

func _input(event): # runs when detects user input
	if event is InputEventMouseMotion: # player looks around
		# rotates sideways when mouse moves sideways
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
	
		# rotates head so that body doesn't end up at odd angles
		head.rotate_x(deg2rad(event.relative.y * mouse_sensitivity))
	
		# so you can't invert your look
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))

# a _physics_process runs once every 60th of a second precisely, a _process runs
# 60 times per second, but not necessarily at even intervals. "delta" is the time between
# the current interval and the previous one
func _process(delta):
	direction = Vector3()
	# is_action_just_pressed is used when you want ignore 
	# buttons being held down, one trigger per press
	if Input.is_action_just_pressed("ui_cancel"):
		if mouse_locked == true:
			# unlocks the mouse and makes it visible
			mouse_locked = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			# locks the mouse again
			mouse_locked = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if not is_on_floor(): # gravity
		fall.y -= gravity * delta
	if Input.is_action_just_pressed("jump") and is_on_floor(): # so player cant jump in air
		fall.y = jump
	
	# is_action_pressed is for seeing if the button is held and re-executing the command
	if Input.is_action_pressed("ui_down"):
		direction -= transform.basis.z
	
	if Input.is_action_pressed("ui_up"):
		direction += transform.basis.z
	
	if Input.is_action_pressed("ui_left"):
		direction += transform.basis.x
	
	if Input.is_action_pressed("ui_right"):
		direction -= transform.basis.x
	
	direction = direction.normalized() # for turning
	# next two lines for moving smoothly
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP) # gravity
