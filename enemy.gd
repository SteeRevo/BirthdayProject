extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	hit_by_attack(area)
	
func hit_by_attack(area):
	print("Hit by attack")
	#global_position += area.get_global_transform().basis.z * 4
	var tween = create_tween()
	tween.tween_property(self, "position", global_position + area.get_global_transform().basis.z * 2, 0.25)
	tween.tween_property($Sprite3D, "modulate", Color.RED, 0.25)
	tween.connect("finished", on_tween_finished)

func on_tween_finished():
	var tween = create_tween()
	tween.tween_property($Sprite3D, "modulate", Color.WHITE, 0.1)
