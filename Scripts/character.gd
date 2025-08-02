extends CharacterBody2D


@export var SPEED = 100.0
@export var JUMP_VELOCITY = -250.0
@export var paused = false

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	if paused == false:
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.

		var direction := Input.get_axis("move_left", "move_right")
		
		if direction > 0:
			$AnimatedSprite2D.flip_h = true
		elif direction < 0:
			$AnimatedSprite2D.flip_h = false

		if is_on_floor():
			if direction == 0:
				$AnimatedSprite2D.play('idle')
			else:
				$AnimatedSprite2D.play('running')
		else:
			$AnimatedSprite2D.play('jump')

		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
