extends CharacterBody2D

@export var run_speed = 350
@export var jump_speed = -1150
@export var gravity = 2500
var screen_size
var jump_max = 2
@export var jump_count = 0

signal jumping
signal landed




# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("move_right")
	var left = Input.is_action_pressed("move_left")
	
	#use is_action_just_pressed so as not to multi count jumps
	if jump_count<jump_max and Input.is_action_just_pressed("jump"):
		print(jump_count)
		velocity.y = jump_speed
		jump_count+=1
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed


func _physics_process(delta):
	velocity.y += gravity * delta
	if is_on_floor() and jump_count!=0:
		jump_count=0
	get_input()
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.play()
	
	if velocity.x !=0:
		$AnimatedSprite2D.animation = "running"
	else:
		$AnimatedSprite2D.animation = "standing"

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func game_over():
	print("Game over man!")
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	game_over()
