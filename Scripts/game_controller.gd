extends Node2D

@export var exit: Node2D

@onready var init_player_pos: Vector2
@onready var collected_keys: int = 0
@onready var key_count = len($World/Keys.get_children())

func _ready() -> void:
	init_player_pos = $World/Player.position
	var tween = create_tween()
	tween.tween_property($UICanvas/ColorRect, 'color:a', 0.0, 0.5).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN).set_delay(0.2)

func restart_level() -> void:
	print('reset')

	$World/Player.paused = false
	exit.close_door()

	for child in $World/Keys.get_children():
		child.show()
		for sub_child in child.get_children():
			if sub_child is CollisionShape2D:
				sub_child.set_deferred("disabled", false)
	collected_keys = 0
	$World/Player.position = init_player_pos

	var tween = create_tween()
	$AudioStreamPlayer.volume_db = 0.0
	$AudioStreamPlayer.play(0.0)
	tween.parallel()
	tween.tween_property($World/Player/Camera2D, "zoom", Vector2(5, 5), 0.4)
	tween.tween_property($UICanvas/ColorRect, 'color:a', 0.0, 0.4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN).set_delay(0.2)
	tween.tween_property($AudioStreamPlayer, 'volume_db', 1.0, 0.4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN).set_delay(0.2)

	$UICanvas/Control.start_countdown()


func check_exit():
	if collected_keys == key_count:
		exit.open_door()
		
func death_anim():
	var tween = create_tween()
	tween.parallel()
	tween.tween_property($World/Player/Camera2D, "zoom", Vector2(10, 10), 0.4)
	tween.tween_property($UICanvas/ColorRect, "color:a", 1.0, 0.4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN).set_delay(0.2)
	tween.tween_property($AudioStreamPlayer, "volume_db", 0.0, 0.4).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN).set_delay(0.2)
	$World/Player.paused = true
	$World/Player/AnimatedSprite2D.play('death')

func _on_control_countdown_completed() -> void:
	death_anim()
	await $World/Player/AnimatedSprite2D.animation_finished
	restart_level()

func _on_key_1_key_collected() -> void:
	collected_keys += 1
	check_exit()
	
func _on_exit_exit_entered() -> void:
	print("you win")
