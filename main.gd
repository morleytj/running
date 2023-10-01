extends Node2D

@export var platform_scene: PackedScene
@export var artifact_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlatformTimer.start()
	$ArtifactTimer.start()
	new_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func game_over():
	$PlatformTimer.stop()


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
	
	#spawn the platform
	add_child(newArtifact)
