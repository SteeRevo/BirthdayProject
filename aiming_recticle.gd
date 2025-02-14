extends Node2D
var last_dir = Vector2.ZERO.angle()
var direction
@export var projectile : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
		var p = projectile.instantiate()
		owner.add_child(p)
		p.transform = global_transform
		
	
	
