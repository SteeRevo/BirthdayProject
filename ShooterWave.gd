extends Node3D

var in_water = false
@export var projectile = preload("res://projectileWave.tscn")
signal firing
var reloading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().in_dialogue == false:
		var input_dir := Input.get_vector("LeoniAimLeft", "LeoniAimRight", "LeoniAimDown", "LeoniAimUp")
		var direction :=  Vector2(input_dir.x, input_dir.y).normalized()
		if direction != Vector2.ZERO:
			rotation_degrees.y = rad_to_deg(direction.angle()) + 90
			if in_water and !reloading:
				var p = projectile.instantiate()
				owner.add_child(p)
				p.current_dir = global_rotation
				p.set_spawn(global_position)
				reloading = true
				emit_signal("firing")
