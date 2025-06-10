extends "res://projectile3D.gd"



func _ready():
	proj_name = "wave"
	timer.timeout.connect(decay)
