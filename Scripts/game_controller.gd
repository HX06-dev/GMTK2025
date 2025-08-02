extends Node2D

@export var exit: Node2D

@onready var init_player_pos: Vector2
@onready var collected_keys: int = 0
@onready var key_count = len($World/Keys.get_children())

func _ready() -> void:
	init_player_pos = $World/Player.position

func restart_level() -> void:
	exit.close_door()
	for child in $World/Keys.get_children():
		child.show()
		for sub_child in child.get_children():
			if sub_child is CollisionShape2D:
				sub_child.set_deferred("disabled", false)
	collected_keys = 0
	$World/Player.position = init_player_pos
	$UICanvas/Control.start_countdown()


func check_exit():
	if collected_keys == key_count:
		exit.open_door()

func _on_control_countdown_completed() -> void:
	restart_level()

func _on_key_1_key_collected() -> void:
	collected_keys += 1
	check_exit()
	
func _on_exit_exit_entered() -> void:
	print("you win")
