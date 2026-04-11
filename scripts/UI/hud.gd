extends CanvasLayer

@onready var gold_value_label: Label = %GoldValueLabel
@onready var gold_icon: TextureRect = %GoldIcon

func _ready() -> void:
    GameManager.gold_changed.connect(_on_gold_changed)
    _on_gold_changed(GameManager.gold)  # Initialize the label with the current gold value


func _on_gold_changed(new_gold: int) -> void:
    var tween := create_tween()
    gold_value_label.text = str(new_gold)
    tween.tween_property(gold_icon, "scale", Vector2(1.1, 1.1), 0.1).set_ease(Tween.EASE_OUT)
    tween.tween_property(gold_icon, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_IN)
    
