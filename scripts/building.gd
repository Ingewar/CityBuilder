extends Node2D
class_name Building

enum BuildingType {
	CLICKER,
	PASSIVE,
	MULTIPLIER
}
@export var building_type : BuildingType
@export var upgrade_costs: Array[int]
@export var upgrade_button: Button
@export_group("Passive Generation")
@export var passive_rate: int = 0
@export var passive_increment: int = 1
@export var timer: Timer
@export_group("Multiplier Effect")
@export var multiplier_value: int = 0
@export var multiplier_increment: int = 1

@onready var tiers: Array[Area2D] = [$Tier0, $Tier1, $Tier2]

var current_tier_index: int = 0
var current_tier: Area2D

func _ready() -> void:
	current_tier = tiers[current_tier_index]
	upgrade_button.pressed.connect(_on_upgrade_label_pressed)
	GameManager.gold_changed.connect(_on_gold_changed)
	_on_gold_changed(GameManager.gold)  # Initialize the upgrade button state
	if building_type == BuildingType.PASSIVE:
		timer.timeout.connect(_on_timer_timeout)

func upgrade():
	if current_tier_index < tiers.size() - 1:
		current_tier.visible = false
		current_tier.process_mode = Node2D.PROCESS_MODE_DISABLED
		current_tier_index += 1
		current_tier = tiers[current_tier_index]
		current_tier.visible = true
		current_tier.process_mode = Node2D.PROCESS_MODE_INHERIT
		if building_type == BuildingType.PASSIVE:
			passive_rate += passive_increment  # Increase passive generation rate
		elif building_type == BuildingType.MULTIPLIER:
			GameManager.click_value += multiplier_increment  # Increase click value
	elif current_tier_index == tiers.size() - 1:
		print("Max tier reached")
		upgrade_button.visible = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Building clicked")
		match building_type:
			BuildingType.CLICKER:
				GameManager.add_gold(GameManager.click_value * current_tier_index)
			BuildingType.PASSIVE:
				# Implement passive gold generation logic here
				pass
			BuildingType.MULTIPLIER:
				# Implement multiplier effect logic here
				pass


func _on_upgrade_label_pressed() -> void:
	print("Upgrade button pressed")
	if GameManager.spend_gold(upgrade_costs[current_tier_index]):
		upgrade()

func _on_gold_changed(new_gold: int) -> void:
	if current_tier_index < upgrade_costs.size() and new_gold >= upgrade_costs[current_tier_index]:
		upgrade_button.disabled = false
	else:
		upgrade_button.disabled = true

func _on_timer_timeout() -> void:
	if building_type == BuildingType.PASSIVE:
		GameManager.add_gold(passive_rate)
