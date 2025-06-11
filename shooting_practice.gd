extends Node3D

@onready var canvas = $CanvasLayer/Control
@onready var player1 = $NavigationRegion3D/Player
@onready var player2 = $NavigationRegion3D/Player2
@onready var textboxPos = $CanvasLayer/Control/TextboxPos
@onready var waterspout1 = $NavigationRegion3D/WaterSpout
@onready var waterspout2 = $NavigationRegion3D/WaterSpout2
@onready var waterspout3 = $NavigationRegion3D/WaterSpout3
@onready var enemy_spawner1 = $NavigationRegion3D/EnemySpawner
@onready var enemy_spawner2 = $NavigationRegion3D/EnemySpawner2
@onready var cutscenePlayer = $NavigationRegion3D/CutscenePlayer
@onready var navigation = $NavigationRegion3D
@onready var restart = $CanvasLayer/Restart
@onready var defeatedLabel = $CanvasLayer/Defeated
@onready var canvasAnimation = $CanvasLayer/AnimationPlayer
var gameover = false

var enemy_killed = 0

const lines: Array[String] = [
	"Hurry Leoni, we have to make it to the harbor",
	"The Fire Nation can't know...",
	"That you're a waterbender!"
]

const lines2: Array[String] = [
	"Hurry Mama, we gotta leave now",
]

func _ready():
	SignalManager.connect("intro_done", start_combat)
	SignalManager.connect("exit_scene", change_scene)
	player1.in_dialogue = true
	player2.in_dialogue = true
	cutscenePlayer.play("walk_to_spot")
	waterspout1.connect("spout_inactive", set_spout)
	waterspout2.connect("spout_inactive", set_spout)
	waterspout3.connect("spout_inactive", set_spout)
	
		
func start_combat():
	print("combat_start")
	player1.in_dialogue = false
	player2.in_dialogue = false
	waterspout1.set_active()
	enemy_spawner1.spawn_enemy()
	enemy_spawner2.spawn_enemy()



func _on_cutscene_player_animation_finished(anim_name):
	if anim_name == "walk_to_spot":
		DialogueManager.start_dialogue(textboxPos.global_position, lines, canvas, "intro_done")


func _on_player_died():
	get_tree().paused = true
	restart.visible = true
	restart.gameover = true


func _on_player_2_died():
	get_tree().paused = true
	restart.visible = true
	restart.gameover = true
	
func set_spout(spout_num):
	print("spout num: " + str(spout_num))
	if spout_num == 1 and waterspout2.active == false and waterspout3.active == false:
		waterspout2.set_active()
	elif spout_num == 2 and waterspout1.active == false and waterspout3.active == false:
		waterspout3.set_active()
	elif spout_num == 3 and waterspout2.active == false and waterspout1.active == false:
		waterspout1.set_active()
		
func enemy_killed_increase():
	enemy_killed += 1
	print(enemy_killed)
	defeatedLabel.update_kill_count(enemy_killed)
	if enemy_killed == 20:
		print("first_level_Complete")
		enemy_spawner1.queue_free()
		enemy_spawner2.queue_free()
		DialogueManager.start_dialogue(textboxPos.global_position, lines2, canvas, "exit_scene")
		


func _on_enemy_spawner_kill_count():
	enemy_killed_increase()


func _on_enemy_spawner_2_kill_count():
	enemy_killed_increase()

func change_scene():
	canvasAnimation.play("transition")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "transition":
		get_tree().change_scene_to_file("res://walk_cutscene.tscn")
