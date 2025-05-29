extends Area3D

@export var player_path : NodePath
var player2 = null
var total_uses = 3
var active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player2 = get_node(player_path)
	player2.shooter.connect("firing", water_used)
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_active():
	visible = true
	active = true
	$AnimationPlayer.play("sprout")

func set_inactive():
	visible = false
	active = false
	

func water_used():
	total_uses -= 1
	if total_uses == 0:
		set_inactive()


func _on_body_entered(body):
	if body.name == "Player2" and active == true:
		print("active")
		body.shooter.in_water = true


func _on_body_exited(body):
	if body.name == "Player2" and active == true:
		print("not active")
		body.shooter.in_water = false
