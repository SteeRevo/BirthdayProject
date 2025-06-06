extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var model = $MamaModel
@onready var model_ap = $MamaModel/AnimationPlayer
var fire = false

@export var health = 1
@export var max_health = 1

@onready var invinTimer = $InvinTimer
@onready var hitbox = $Hitbox

signal health_changed
signal died
var in_dialogue = false


func _physics_process(delta: float) -> void:
	
	if in_dialogue == false:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("Player1Left", "Player1Right", "Player1Up", "Player1Down")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			if fire == true:
				model_ap.play("Walk_Fire")
				fire = false
				
			else:
				model_ap.queue("Walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			if fire == true:
				model_ap.play("fire")
			else:
				model_ap.stop()
				model_ap.queue("tpose")

	move_and_slide()
	model.rotation_degrees.y = $Shooter.rotation_degrees.y

func _on_shooter_firing():
	fire = true
	$AudioStreamPlayer.play()
	
	
func take_damage():
	health -= 1
	health_changed.emit(health)
	invinTimer.start()
	$MamaModel/AnimationPlayer.play("invin")
	hitbox.set_deferred("monitorable", false)
	hitbox.set_deferred("monitoring", false)
	if health <= 0:
		emit_signal("died")
	
func play_walk():
	$MamaModel/AnimationPlayer.play("Walk")

func stop_walk():
	$MamaModel/AnimationPlayer.play("tpose")
	
func play_talk():
	$MamaModel/AnimationPlayer.play("talk")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fire":
		fire = false

func _on_hitbox_area_entered(area):
	print(area.name)
	if area.name == "Enemy":
		take_damage()

func _on_invin_timer_timeout():
	hitbox.set_deferred("monitorable", true)
	hitbox.set_deferred("monitoring", true)
