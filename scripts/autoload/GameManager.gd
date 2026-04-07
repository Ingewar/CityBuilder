extends Node

signal gold_changed(new_gold: int)

var gold: int = 50
var click_value: int = 1

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
