extends Node2D
class_name Building

@onready var tiers: Array[Area2D] = [$Tier0, $Tier1, $Tier2]
@onready var upgrade_label: Button = $UpgradeLabel

var current_tier_index: int = 0
var current_tier: Area2D

func _ready() -> void:
	current_tier = tiers[current_tier_index]

func upgrade():
	if current_tier_index < tiers.size() - 1:
		current_tier.visible = false
		current_tier.process_mode = Node2D.PROCESS_MODE_DISABLED
		current_tier_index += 1
		current_tier = tiers[current_tier_index]
		current_tier.visible = true
		current_tier.process_mode = Node2D.PROCESS_MODE_INHERIT


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Building clicked")


func _on_upgrade_label_pressed() -> void:
	print("Upgrade button pressed")
	upgrade()
