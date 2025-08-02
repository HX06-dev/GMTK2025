extends Control

signal countdown_completed

@export var init_countdown_time: float = 30.0  # Default 60 seconds, editable in inspector
@export var countdown_time: float
@onready var countdown_label: Label = $CountdownLabel
@onready var timer: Timer = $Timer

func _ready():
	# Set up the timer
	timer.wait_time = 1.0  # Update every second
	
	# Position at top of screen
	set_anchors_preset(Control.PRESET_TOP_WIDE)
	size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	# Start the countdown
	start_countdown()

func start_countdown():
	countdown_time = init_countdown_time
	update_countdown_display()
	timer.start()

func _on_timer_timeout():
	countdown_time -= 1.0
	update_countdown_display()
	
	if countdown_time <= 0:
		timer.stop()
		countdown_finished()

func update_countdown_display():
	# Format the time as MM:SS
	var minutes = floor(countdown_time / 60)
	var seconds = int(countdown_time) % 60
	countdown_label.text = "%02d:%02d" % [minutes, seconds]
	
	# Optional: Change color when time is low
	if countdown_time <= 10:
		countdown_label.add_theme_color_override("font_color", Color.RED)
	else:
		countdown_label.add_theme_color_override("font_color", Color.WHITE)

func countdown_finished():
	print("Countdown finished!")
	# Add any actions you want to happen when countdown reaches zero
	countdown_label.text = "00:00"
	emit_signal("countdown_completed")  # You can connect to this signal elsewhere

# Optional: Add this if you want to be able to pause/resume
func set_countdown_active(active: bool):
	if active:
		timer.start()
	else:
		timer.stop()
