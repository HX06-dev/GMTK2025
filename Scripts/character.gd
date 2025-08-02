extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -250.0

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	print(direction)
	if direction:
		velocity.x = direction * SPEED
		if $AnimatedSprite2D.scale.x != -direction:
			$AnimatedSprite2D.scale.x = -direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
