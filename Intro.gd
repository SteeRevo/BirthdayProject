extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$TitleScreen/Timer.timeout.connect(change_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func change_scene():
	get_tree().change_scene_to_file("res://shooting_practice.tscn")


func _on_video_stream_player_finished():
	$TitleScreen/AnimationPlayer.play("fade")
	$TitleScreen/AudioStreamPlayer.play()
	$TitleScreen/Timer.start()
