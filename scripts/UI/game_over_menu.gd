extends Control

@onready var play_time_value: Label = %PlayTimeValue
@onready var replay_button: Button = %ReplayButton
@onready var exit_button: Button = %ExitButton

func _ready() -> void:
	replay_button.pressed.connect(_on_replay_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	play_time_value.text = str(GameManager.play_time)

func _on_replay_button_pressed() -> void:
	SceneManager.change_scene(SceneManager.Scene.GAME)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
