extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var model = $MamaModel
@onready var model_ap = $MamaModel/AnimationPlayer
var fire = false


func _physics_process(delta: float) -> void:
	

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
	
	


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fire":
		fire = false
