extends Node

signal gold_changed(new_gold: int)
signal game_over()
@warning_ignore("unused_signal")
signal show_tooltip(text: String)
@warning_ignore("unused_signal")
signal hide_tooltip()

@export var gold: int = 50
@export var click_value: int = 1

var play_time: String = ""

const BUILDING_AMOUNT: int = 5
var _building_reached_max_tier_count: int = 0
var _start_time_ms: int = 0

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

func start_play_time() -> void:
    _start_time_ms = Time.get_ticks_msec()

func _get_play_time() -> String:
    var total_seconds: int = (Time.get_ticks_msec() - _start_time_ms) / 1000
    var minutes: int = total_seconds / 60
    var seconds: int = total_seconds % 60
    return "%02d:%02d" % [minutes, seconds]

func notify_max_tier_reached() -> void:
    _building_reached_max_tier_count += 1
    if _building_reached_max_tier_count >= BUILDING_AMOUNT:
        play_time = _get_play_time()
        game_over.emit()
