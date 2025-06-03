extends Control

var gameover = false

func _unhandled_input(event):
	if gameover == true:
		if event.is_action_pressed("DialogueAdvance"):
			get_tree().paused = false
			get_tree().change_scene_to_file("res://shooting_practice.tscn")
