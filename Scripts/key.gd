extends Area2D

@onready var sprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	var tween = create_tween()
	$CollisionShape2D.set_deferred("disabled", true)
	tween.set_parallel(true)
	tween.tween_property(sprite, "position:y", sprite.position.y - 20, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	# Fade out (with slight delay)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN).set_delay(0.2)
	
	# Scale up
	tween.tween_property(sprite, "scale", sprite.scale * 1.5, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	# When animation completes, remove the key
	await tween.finished
	hide()
	$AnimatedSprite2D.modulate.a = 1.0
	$AnimatedSprite2D.scale = Vector2(1.0, 1.0)
	$AnimatedSprite2D.position.y = 0.0
