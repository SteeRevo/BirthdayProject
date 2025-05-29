extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var fire = false
@onready var model = $sister
@onready var model_ap = $sister/AnimationPlayer
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var shooter = $Shooter
@onready var sfx = $AudioStreamPlayer
@onready var hitbox = $Hitbox

@export var health = 1
@export var max_health = 1

signal health_changed
@onready var invinTimer = $InvinTimer

var in_dialogue = false


func _physics_process(delta):

	if in_dialogue == false:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir := Input.get_vector("LeoniLeft", "LeoniRight", "LeoniUp", "LeoniDown")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			if fire == true:
				
				model_ap.play("Water")
				fire == false		
			else:
				model_ap.play("Walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			if fire == true:
				model_ap.play("Water")
				fire == false	
			else:
				model_ap.play("Idle")

		move_and_slide()
		model.rotation_degrees.y = $Shooter.rotation_degrees.y

func take_damage():
	health -= 1
	health_changed.emit(health)
	invinTimer.start()
	$sister/AnimationPlayer.play("invin")
	hitbox.monitorable = false
	print(health)
	
func play_walk():
	$sister/AnimationPlayer.play("Walk")

func stop_walk():
	$sister/AnimationPlayer.play("Idle")	

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Water":
		fire = false
		$Shooter.reloading = false


func _on_shooter_firing():
	fire = true
	$AudioStreamPlayer.play()


func _on_hitbox_area_entered(area):
	print(area.name)
	if area.name == "Enemy":
		take_damage()


func _on_invin_timer_timeout():
	hitbox.monitorable = true
