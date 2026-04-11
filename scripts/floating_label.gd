extends MarginContainer

@export var floating_duration: float = 1.0
@export var final_position_offset: Vector2 = Vector2(0, -40)
@export var label_text: String = "+1"

@onready var label: Label = $HBoxContainer/FloatingLabel

func setup(value: String) -> void:
	label_text = value

func _ready() -> void:
	label.text = label_text
	var tween := create_tween().set_parallel(true)
	tween.tween_property(self, "position", position + final_position_offset, floating_duration).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "modulate:a", 0.0, floating_duration)
	tween.chain().tween_callback(queue_free)
