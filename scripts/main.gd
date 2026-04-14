extends Node2D

@onready var game_over_timer: Timer = %GameOverTimer

func _on_game_over_timer_timeout() -> void:
	GameManager.time_remaining = 0.0
	SceneManager.change_scene(SceneManager.Scene.GAME_OVER)
