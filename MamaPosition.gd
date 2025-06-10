extends Node3D

@onready var ap = $"20250222Mama/AnimationPlayer"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_walk():
	ap.play("Walk")
	
func play_talk():
	ap.play("talk")
	
func play_idle():
	ap.play("tpose")
