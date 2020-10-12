extends KinematicBody

var melee_damage = 50

var speed = 10
var acceleration = 6
var gravity = 20
var h_acceleration = 6
var air_acceleration = 1
var normal_acceleration = 6
var jump = 10
var full_contact = false

var mouse_sensitivity = 0.1

var direction = Vector3()
var h_velocity = Vector3()
var movement = Vector3()
var gravity_vec = Vector3()

const SWAY = 30
const VSWAY = 50

onready var head = $Head
onready var ground_check = $GroundCheck
onready var hand = $Head/Camera/Hand
onready var handloc = $Head/Camera/HandLoc
onready var camera_anim = $Head/Camera/CameraAnimationPlayer

onready var melee_anim = $AnimationPlayer
onready var hitbox  = $Head/Camera/Hitbox



func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	hand.set_as_toplevel(true)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-90), deg2rad(90))
		
func melee():
	if Input.is_action_just_pressed("fire"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if not melee_anim.is_playing():
			melee_anim.play("Attack")
			melee_anim.play("Return")
		if melee_anim.current_animation == "Attack":
			for body in hitbox.get_overlapping_bodies():
				if body.is_in_group("Enemy"):
					body.health -= melee_damage
	


func _process(delta):
	
	hand.global_transform.origin = handloc.global_transform.origin
	hand.rotation.y = lerp_angle(hand.rotation.y, rotation.y, SWAY * delta)
	hand.rotation.x = lerp_angle(hand.rotation.x, rotation.x, VSWAY * delta)
	melee()
	
	direction = Vector3()
	
	if ground_check.is_colliding():
		full_contact = true
	else:
		full_contact = false
	
	if not is_on_floor():
		gravity_vec += Vector3.DOWN * gravity * delta
		h_acceleration = air_acceleration
	elif is_on_floor() and full_contact:
		gravity_vec = -get_floor_normal() * gravity
		h_acceleration = normal_acceleration
	else:
		gravity_vec = -get_floor_normal()
		h_acceleration = normal_acceleration
		
		
	if Input.is_action_just_pressed("jump") and (is_on_floor() or ground_check.is_colliding()):
		gravity_vec = Vector3.UP * jump
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_pressed("move_forward"):
		direction -= transform.basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += transform.basis.z
	if Input.is_action_pressed("move_left"):
		direction -= transform.basis.x
	elif Input.is_action_pressed("move_right"):
		direction += transform.basis.x

		
	direction = direction.normalized()
	h_velocity = h_velocity.linear_interpolate(direction*speed, acceleration*delta)
	movement.z = h_velocity.z + gravity_vec.z
	movement.x = h_velocity.x + gravity_vec.x
	movement.y = gravity_vec.y
	move_and_slide(movement, Vector3.UP)
	
	if direction != Vector3():
		camera_anim.play("HeadBop")
	else:
		camera_anim.stop()
		

