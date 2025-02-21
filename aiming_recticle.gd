extends Node2D
var last_dir = Vector2.ZERO.angle()
var direction
@export var projectile = preload("res://projectile.tscn")

@onready var timer = $Timer
var reloading = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(reload_start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	direction = Input.get_vector("Player2Left", "Player2Right", "Player2Up", "Player2Down")
	if direction == Vector2.ZERO:
		rotation = last_dir
		print(last_dir)
	else: 
		rotation = direction.angle()
		last_dir = rotation
		print(last_dir)
		if !reloading:
			var p = projectile.instantiate()
			owner.add_child(p)
			p.global_position = $Sprite2D.global_position
			p.global_rotation = $Sprite2D.global_rotation
			timer.start()
			reloading = true
		
func reload_start():
	reloading = false
	
