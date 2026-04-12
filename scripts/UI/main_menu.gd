extends Control

@onready var play_button: Button = %PlayButton
@onready var exit_button: Button = %ExitButton

func _ready():
	play_button.pressed.connect(_on_play_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)


func _on_play_button_pressed() -> void:
	print("Play button pressed. Starting game.")
	SceneManager.change_scene(SceneManager.Scene.GAME)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
