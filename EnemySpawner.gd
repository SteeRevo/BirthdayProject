extends Node3D

@export var enemy = preload("res://Enemy/enemy.tscn")
@onready var player_path = %Player2
@onready var player_path2 = %Player
@onready var timer = $Timer
var enemy_amt = 0

func spawn_enemy():
	var e = enemy.instantiate()
	owner.add_child(e)
	e.global_position = global_position
	if randi() % 2 == 0:
		e.player = player_path
	else:
		e.player = player_path2
	enemy_amt += 1
	e.connect("enemy_death", decrease_enemy_amt)
	timer.start()


func _on_timer_timeout():
	if enemy_amt < 3:
		spawn_enemy()
		timer.start()

func decrease_enemy_amt():
	enemy_amt -= 1
	timer.start()
