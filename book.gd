extends RigidBody2D
@export var fall_speed = 300
signal BookGrabbed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	#position.y += fall_speed*delta
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.get_name()=="Player":
		BookGrabbed.emit()
		queue_free()
