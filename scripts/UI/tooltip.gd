extends Control

const CURSOR_OFFSET := Vector2(15.0, 15.0)

@onready var text_label: Label = %Text

func _ready() -> void:
	GameManager.show_tooltip.connect(_on_show_tooltip)
	GameManager.hide_tooltip.connect(_on_hide_tooltip)
	hide()

func _on_show_tooltip(text: String) -> void:
	text_label.text = text
	show()
	_update_position()

func _on_hide_tooltip() -> void:
	hide()

func _update_position() -> void:
	var mouse_pos := get_viewport().get_mouse_position()
	var viewport_size := get_viewport().get_visible_rect().size
	var pos := mouse_pos + CURSOR_OFFSET
	pos.x = clamp(pos.x, 0.0, viewport_size.x - size.x)
	pos.y = clamp(pos.y, 0.0, viewport_size.y - size.y)
	position = pos
