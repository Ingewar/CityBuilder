extends Node2D

func _ready() -> void:
	GameManager.start_play_time()
	GameManager.game_over.connect(_on_game_over)

func _on_game_over() -> void:
	SceneManager.change_scene(SceneManager.Scene.GAME_OVER)
