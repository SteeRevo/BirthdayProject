extends Node3D
@onready var ap = $AnimationPlayer
@onready var canvasAP = $CanvasLayer/AnimationPlayer
@onready var textboxPos = $CanvasLayer/Control/TextboxPos
@onready var canvas = $CanvasLayer/Control

const lines: Array[String] = [
	"Ugh! Aaaaaaah!",
	"Mama, I can't go on anymore.",
	"I think I broke my foot."
]

const lines2: Array[String] = [
	"Oh no, let me check!",
	"Let's see whats going on.....",
	"It's a piece of rice."
]

const lines3: Array[String] = [
	"...Ok, let's keep going."
]


# Called when the node enters the scene tree for the first time.
func _ready():
	canvasAP.play("enter_scene")
	SignalManager.connect("check_foot", check_foot_animation)
	SignalManager.connect("move_on", move_on)
	SignalManager.connect("exit_scene", exit_scene)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "enter_scene":
		ap.play("Walk_to_Collapse")
	if anim_name == "Walk_to_Collapse":
		DialogueManager.start_dialogue(textboxPos.global_position, lines, canvas, "check_foot")
	if anim_name == "check_foot":
		DialogueManager.start_dialogue(textboxPos.global_position, lines2, canvas, "move_on")
	if anim_name == "move_on":
		DialogueManager.start_dialogue(textboxPos.global_position, lines3, canvas, "exit_scene")
	if anim_name == "exit_scene":
		get_tree().change_scene_to_file("res://end_scene.tscn")

func check_foot_animation():
	ap.play("check_foot")

func move_on():
	ap.play("move_on")
	
func exit_scene():
	print("exit scene")
	canvasAP.play("exit_scene")
