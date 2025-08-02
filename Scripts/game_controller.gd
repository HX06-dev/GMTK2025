extends Node2D

var init_player_pos: Vector2

func _ready() -> void:
	init_player_pos = $World/Player.position

func restart_level() -> void:
	for child in $World/Keys.get_children():
		print(child)
		child.show()
		for sub_child in child.get_children():
			if sub_child is CollisionShape2D:
				sub_child.set_deferred("disabled", false)
	$World/Player.position = init_player_pos
	$UICanvas/Control.start_countdown()

func _on_control_countdown_completed() -> void:
	restart_level()
