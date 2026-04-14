extends Control

@onready var replay_button: Button = %ReplayButton
@onready var exit_button: Button = %ExitButton
@onready var score_value: Label = %ScoreValue

func _ready() -> void:
	replay_button.pressed.connect(_on_replay_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	score_value.text = str(int(GameManager.time_remaining * 10))

func _on_replay_button_pressed() -> void:
	SceneManager.change_scene(SceneManager.Scene.GAME)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
