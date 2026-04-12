extends Node

var game_over_scene: PackedScene = preload("res://scenes/HUD/game_over_menu.tscn")
var main_menu_scene: PackedScene = preload("res://scenes/HUD/main_menu.tscn")
var main_scene: PackedScene = preload("res://scenes/main.tscn")

enum Scene { MAIN_MENU, GAME, GAME_OVER }

func load_scene(scene: PackedScene) -> void:
	get_tree().change_scene_to_packed(scene)

func change_scene(scene: Scene) -> void:
	match scene:
		Scene.MAIN_MENU:
			load_scene(main_menu_scene)
		Scene.GAME:
			load_scene(main_scene)
		Scene.GAME_OVER:
			load_scene(game_over_scene)
