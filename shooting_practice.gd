extends Node3D

@onready var canvas = $CanvasLayer/Control

const lines: Array[String] = [
	"hello there",
	"This is the avatar birthday game",
]

func _unhandled_input(event):
	if event.is_action_pressed("DialogueAdvance"):
		print("dialogue")
		#DialogueManager.start_dialogue(Vector2(150, 70), lines, canvas)
