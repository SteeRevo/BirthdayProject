extends Area3D

signal hit

func _on_area_entered(area: Area3D) -> void:
	hit_by_attack(area)
	
func hit_by_attack(area):
	emit_signal("hit", area)
	
