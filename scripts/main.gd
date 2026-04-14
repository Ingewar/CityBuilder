extends Node2D

@onready var game_over_timer: Timer = %GameOverTimer

func _on_game_over_timer_timeout() -> void:
	SceneManager.change_scene(SceneManager.Scene.GAME_OVER)
	GameManager.game_over.emit(0.0)
