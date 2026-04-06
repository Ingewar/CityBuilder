extends Node

const GAME_OVER = "res://scenes/UI/game_over.tscn"
const GAME = "res://main.tscn"

func change_scene(scene_path: String):
    call_deferred("_do_change_scene", scene_path)

func _do_change_scene(scene_path: String):
    get_tree().change_scene_to_file(scene_path)
