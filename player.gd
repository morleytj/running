extends Area2D

@export var speed = 400
var screen_size

signal jumping
signal landed




# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var extra_pos = 1
	#inputs
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("jump"):
		velocity.y-=1
		extra_pos = 2
		jumping.emit()
	if Input.is_action_pressed("fall_fast"):
		velocity.y+=1
		extra_pos = 2
	
	#Always play animation because they'll either be standing or walking
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	$AnimatedSprite2D.play()
	
	position += velocity * delta * extra_pos
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x !=0:
		$AnimatedSprite2D.animation = "running"
	else:
		$AnimatedSprite2D.animation = "standing"


