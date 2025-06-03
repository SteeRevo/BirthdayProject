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
var gameover = false

const lines: Array[String] = [
	"Hurry Leoni, we have to make it to the harbor",
	"The Fire Nation can't know...",
	"That you're a waterbender!"
]

func _ready():
	SignalManager.connect("intro_done", start_combat)
	player1.in_dialogue = true
	player2.in_dialogue = true
	cutscenePlayer.play("walk_to_spot")
	
		
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
