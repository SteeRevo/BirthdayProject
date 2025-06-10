extends Control
@onready var kill_count = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	kill_count.text = "Defeated: 0" 

func update_kill_count(num):
	kill_count.text = "Defeated: " + str(num)
