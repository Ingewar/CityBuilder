extends CanvasLayer

@onready var gold_value_label: Label = %GoldValueLabel

func _ready() -> void:
    GameManager.gold_changed.connect(_on_gold_changed)
    _on_gold_changed(GameManager.gold)  # Initialize the label with the current gold value


func _on_gold_changed(new_gold: int) -> void:
    gold_value_label.text = str(new_gold)
