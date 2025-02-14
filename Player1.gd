extends CharacterBody2D


const SPEED = 200.0



func _physics_process(delta):


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("Player1Left", "Player1Right", "Player1Up", "Player1Down")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

	
