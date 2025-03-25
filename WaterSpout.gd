extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	%Player2.shooter.connect("firing", water_used)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "Player2":
		print("active")
		body.shooter.in_water = true


func _on_body_exited(body):
	if body.name == "Player2":
		print("not active")
		body.shooter.in_water = false

func water_used():
	queue_free()
