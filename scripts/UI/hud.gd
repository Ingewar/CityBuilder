extends CanvasLayer

@onready var gold_value_label: Label = %GoldValueLabel
@onready var gold_icon: TextureRect = %GoldIcon
@onready var time_left_value: Label = %TimeLeftValue

func _ready() -> void:
    GameManager.gold_changed.connect(_on_gold_changed)
    GameManager.time_updated.connect(_on_time_updated)
    _on_gold_changed(GameManager.gold) # Initialize the label with the current gold value


func _on_gold_changed(new_gold: int) -> void:
    var tween := create_tween()
    gold_value_label.text = str(new_gold)
    tween.tween_property(gold_icon, "scale", Vector2(1.1, 1.1), 0.1).set_ease(Tween.EASE_OUT)
    tween.tween_property(gold_icon, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_IN)

func _on_time_updated(new_time: int) -> void:
    time_left_value.text = "%d:%02d" % [new_time / 60 as int, new_time % 60]
