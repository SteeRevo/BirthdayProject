extends Node3D

@export var enemy = preload("res://Enemy/enemy.tscn")
@onready var player_path = %Player2

func spawn_enemy():
	var e = enemy.instantiate()
	owner.add_child(e)
	e.global_position = global_position
	e.player = player_path
