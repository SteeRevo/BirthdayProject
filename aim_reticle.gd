extends Area3D
@export var projectile = preload("res://projectile3D.tscn")
@onready var timer = $Timer
var reloading = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(reload_start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var input_dir := Input.get_vector("Player2Left", "Player2Right", "Player2Down", "Player2Up")
	var direction :=  Vector2(input_dir.x, input_dir.y).normalized()
	if direction != Vector2.ZERO:
		rotation_degrees.y = rad_to_deg(direction.angle()) + 90
		if !reloading:
			var p = projectile.instantiate()
			owner.add_child(p)
			p.current_dir = $Sprite3D.global_rotation
			p.set_spawn($Sprite3D.global_position)
			timer.start()
			reloading = true
		
func reload_start():
	reloading = false
