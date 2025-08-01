extends Node2D

signal exit_entered

@export var is_open = false

func open_door():
	$Sprite2D.region_rect = Rect2(32, 0, 32, 32)
	is_open = true
	$PointLight2D.enabled = true
	
func close_door():
	$Sprite2D.region_rect = Rect2(0, 0, 32, 32)
	is_open = false
	$PointLight2D.enabled = false

func _on_body_entered(body: Node2D) -> void:
	if is_open == true:
		emit_signal("exit_entered")
