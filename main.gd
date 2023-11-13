extends Node2D

@export var platform_scene: PackedScene
@export var artifact_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlatformTimer.start()
	$ArtifactTimer.start()
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()



func _on_platform_timer_timeout():
	#Create a new falling platform
	var newPlat = platform_scene.instantiate()
	
	#Choose a random location on the platform spawn path
	var platform_spawn_loc = get_node("PlatformSpawnPath/PlatformSpawnLocation")
	platform_spawn_loc.progress_ratio = randf()
	
	#Set random position using the created var
	newPlat.position = platform_spawn_loc.position
	
	#Pick fallspeed
	var fall = randf_range(150.0, 250.0)
	newPlat.fall_speed=fall
	
	#spawn the platform
	add_child(newPlat)
	



func _on_artifact_timer_timeout():
	#create artifacts
	var newArtifact = artifact_scene.instantiate()
	
	#artifact path
	var artifact_spawn_loc = get_node("ArtifactSpawnPath/ArtifactSpawnLocation")
	artifact_spawn_loc.progress_ratio = randf()
	
	#Set random position using the created var
	newArtifact.position = artifact_spawn_loc.position
	
	#connect signal
	newArtifact.BookGrabbed.connect(_on_BookGrabbed)
	
	#spawn the artifact
	add_child(newArtifact)

func _on_BookGrabbed():
	score+=1
	print(score)
	$Score.set_text(str(score))


func _on_player_game_over():
	$PlatformTimer.stop()
	score=0
	get_tree().change_scene_to_file("res://menu.tscn")
