extends Area2D

var speed = 30
var spawn_transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * speed * delta
