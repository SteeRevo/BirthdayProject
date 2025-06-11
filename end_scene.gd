extends Node3D
@onready var ap = $AnimationPlayer
@onready var canvasAP = $CanvasLayer/AnimationPlayer
@onready var textboxPos = $CanvasLayer/Control/TextboxPos
@onready var canvas = $CanvasLayer/Control

const lines: Array[String] = [
	"We made it to the boat, Leoni!",
	"Keep going east, you'll find your brothers in the Earth Kingdom",
	"I know you'll be an amazing waterbender",
	"Thanks, Mama. Love you."
]

# Called when the node enters the scene tree for the first time.
func _ready():
	canvasAP.play("enter_scene")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "enter_scene":
		ap.play("Walk_to_boat")
	if anim_name == "Walk_to_boat":
		DialogueManager.start_dialogue(textboxPos.global_position, lines, canvas, null)
