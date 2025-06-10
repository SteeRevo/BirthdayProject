extends Node3D

@onready var ap = $sister/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func play_collapse():
	ap.play("collapse")
	
func play_idle():
	ap.play("Idle")
	
func play_walk():
	ap.play("Walk")

func play_get_up():
	ap.play_backwards("collapse")
