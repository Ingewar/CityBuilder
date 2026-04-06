extends Node2D

@export var gold: int = 0

func add_gold(amount: int) -> void:
    gold += amount
    print("Gold added: ", amount, " Total gold: ", gold)
