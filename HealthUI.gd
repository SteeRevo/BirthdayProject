extends Control

var health = 1
var max_hearts = 1

@export var Player : CharacterBody3D

func set_hearts(value):
	health = clamp(value, 0, max_hearts)
	if Player.name == "Player":
		$Label.text = "Mama: " + str(health)
	if Player.name == "Player2":
		$Label.text = "Leoni: " + str(health)

func set_max_hearts(value):
	max_hearts = max(value, 1)
	if Player.name == "Player":
		$Label.text = "Mama: " + str(health)
	if Player.name == "Player2":
		$Label.text = "Leoni: " + str(health)

func _ready():
	self.max_hearts = Player.max_health
	self.health = Player.health
	Player.connect("health_changed", set_hearts)
	if Player.name == "Player":
		$Label.text = "Mama: " + str(health)
	if Player.name == "Player2":
		$Label.text = "Leoni: " + str(health)
