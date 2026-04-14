extends Node

signal gold_changed(new_gold: int)
@warning_ignore("unused_signal")
signal show_tooltip(text: String)
@warning_ignore("unused_signal")
signal hide_tooltip()

@export var gold: int = 50
@export var click_value: int = 1
var time_remaining: float = 0.0

const BUILDING_AMOUNT: int = 1
var _building_reached_max_tier_count: int = 0

func _ready() -> void:
    print("GameManager ready. Initial gold: ", gold)

func add_gold(amount: int) -> void:
    gold += amount
    gold_changed.emit(gold)

    print("Gold added: ", amount, " Total gold: ", gold)

func spend_gold(amount: int) -> bool:
    if gold >= amount:
        gold -= amount
        gold_changed.emit(gold)
        print("Gold spent: ", amount, " Remaining gold: ", gold)
        return true
    else:
        print("Not enough gold to spend. Required: ", amount, " Available: ", gold)
        return false

func notify_max_tier_reached() -> void:
    _building_reached_max_tier_count += 1
    if _building_reached_max_tier_count >= BUILDING_AMOUNT:
        time_remaining = get_tree().get_current_scene().get_node("GameOverTimer").time_left
        SceneManager.change_scene(SceneManager.Scene.GAME_OVER)
