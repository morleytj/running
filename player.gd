extends CharacterBody2D

@export var run_speed = 350
@export var jump_speed = -1000
@export var gravity = 2500
var screen_size

signal jumping
signal landed




# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	var jump = Input.is_action_pressed("jump")
	
	if is_on_floor() and jump:
		velocity.y = jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play()
	
	if velocity.x !=0:
		$AnimatedSprite2D.animation = "running"
	else:
		$AnimatedSprite2D.animation = "standing"


