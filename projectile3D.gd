extends Area3D
var current_dir
var spawn_set = false
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.timeout.connect(decay)
	
func set_spawn(spawn_pos):
	if !spawn_set:
		global_position = spawn_pos
		spawn_set = true
		global_rotation = current_dir

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += get_global_transform().basis.z * 0.1

func decay():
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	queue_free()
