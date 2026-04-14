extends Node2D

var _last_time_left: int = 0

@onready var game_over_timer: Timer = %GameOverTimer

func _process(_delta: float) -> void:
	var time_left := int(game_over_timer.time_left)
	if time_left != _last_time_left:
		_last_time_left = time_left
		GameManager.time_updated.emit(time_left)

func _on_game_over_timer_timeout() -> void:
	GameManager.time_remaining = 0.0
	SceneManager.change_scene(SceneManager.Scene.GAME_OVER)
