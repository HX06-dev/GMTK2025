extends StaticBody2D

var is_interactable = false

@onready var sprite = $DoorSprite

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_interactable == true:
		var tween = create_tween()
		$DoorCollision.set_deferred("disabled", true)
		$InteractionArea/InteractionCollision.set_deferred("disabled", true)
		tween.set_parallel(true)
		tween.tween_property(sprite, "position:y", sprite.position.y - 16, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_interaction_area_body_entered(body: Node2D) -> void:
	is_interactable = true

func _on_interaction_area_body_exited(body: Node2D) -> void:
	is_interactable = false
