extends CharacterBody3D

var player = null
var nav_agent = null

const SPEED = 3.0

@export var player_path: NodePath

var hit = false

var ROTATION_WEIGHT = 10

var enemy_health = 3
@onready var timer = $Timer

signal enemy_death()

func _ready():
	# Get player node
	timer.timeout.connect(end_invincible)

	# Assuming NavigationAgent3D is a child node; adjust path if necessary
	nav_agent = $NavigationAgent3D

func _process(delta):
	# Ensure nav_agent and player are valid
	if !hit:
		if nav_agent and player:
			# Set target position for the navigation agent
			nav_agent.set_target_position(player.global_transform.origin)

			# Get the next navigation point
			var next_nav_point = nav_agent.get_next_path_position()

			# Calculate velocity
			var direction = (next_nav_point - global_transform.origin).normalized()
			var desired_rotation_y = atan2(direction.x, direction.z)

			rotation.y = lerp_angle(rotation.y, desired_rotation_y, ROTATION_WEIGHT * delta)
			
			velocity = direction * SPEED

			# Move the character

			move_and_slide()
	pass


func _on_enemy_hit(area):
	print(area.name)
	if "proj_name" in area:
		timer.start()
		if area.proj_name == "fireball" or area.proj_name == "wave": 
			hit = true
			$AudioStreamPlayer.play()
			var tween = create_tween()
			tween.tween_property(self, "position", global_position + area.get_global_transform().basis.z * 5, 0.25)
			tween.connect("finished", on_tween_finished)
			if area.proj_name == "fireball":
				enemy_health -= 1
				print(enemy_health)
			elif area.proj_name == "wave":
				enemy_health -= 3
				print(enemy_health)
			if enemy_health <= 0:
				visible = false
			set_invincible()
	elif area.name == "Hitbox":
		var tween = create_tween()
		tween.tween_property(self, "position", global_position - self.get_global_transform().basis.z * 5, 0.25)
		tween.connect("finished", on_tween_finished)

func set_invincible():
	$Enemy/CollisionShape3D.set_deferred("disabled", true)
	
func end_invincible():
	$Enemy/CollisionShape3D.set_deferred("disabled", false)

func on_tween_finished():
	var tween = create_tween()
	hit = false
	



func _on_audio_stream_player_finished():
	if enemy_health <= 0:
		emit_signal("enemy_death")
		queue_free()
