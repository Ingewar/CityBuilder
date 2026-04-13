extends Node2D
class_name Building

enum BuildingType {
	CLICKER,
	PASSIVE,
	MULTIPLIER
}
@export var building_type: BuildingType
@export var upgrade_costs: Array[int]
@export var upgrade_button: UpgradeButton
@export var floating_label_scene: PackedScene = preload("res://scenes/floating_label.tscn")
@export_group("Tooltip")
@export_multiline var tooltip_text: String = ""
@export var tooltip_delay: float = 0.3
@export_group("Passive Generation")
@export var passive_rate: int = 0
@export var passive_increment: int = 5
@export var timer: Timer
@export var gold_spawn_marker: Marker2D
@export_group("Multiplier Effect")
@export var multiplier_value: int = 0
@export var multiplier_increment: int = 1

@onready var tiers: Array[Area2D] = [$Tier0, $Tier1, $Tier2]

var current_tier_index: int = 0
var current_tier: Area2D
var tooltip_timer: Timer

func _ready() -> void:
	#region Tooltip setup
	tooltip_timer = Timer.new()
	tooltip_timer.one_shot = true
	tooltip_timer.wait_time = tooltip_delay
	add_child(tooltip_timer)
	tooltip_timer.timeout.connect(_show_tooltip)
	for tier in tiers:
		tier.mouse_entered.connect(tooltip_timer.start)
		tier.mouse_exited.connect(_on_tier_mouse_exited)
	#endregion

	current_tier = tiers[current_tier_index]
	upgrade_button.pressed.connect(_on_upgrade_label_pressed)
	upgrade_button.set_cost(upgrade_costs[current_tier_index])
	GameManager.gold_changed.connect(_on_gold_changed)
	_on_gold_changed(GameManager.gold) # Initialize the upgrade button state
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
		upgrade_button.set_cost(upgrade_costs[current_tier_index])
		# Apply building-specific effects on upgrade
		var tween := create_tween()
		tween.tween_property(current_tier, "scale", Vector2(1.1, 1.1), 0.1).set_ease(Tween.EASE_OUT)
		tween.tween_property(current_tier, "scale", Vector2(1, 1), 0.1).set_ease(Tween.EASE_IN)
		if building_type == BuildingType.PASSIVE:
			passive_rate += passive_increment # Increase passive generation rate
			timer.start() # Restart timer to apply new rate immediately
		elif building_type == BuildingType.MULTIPLIER:
			GameManager.click_value += multiplier_increment # Increase click value
		# Check if we just reached max tier
		if current_tier_index == tiers.size() - 1:
			print("Max tier reached")
			GameManager.notify_max_tier_reached()
			upgrade_button.visible = false


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		match building_type:
			BuildingType.CLICKER:
				if current_tier_index > 0:
					GameManager.add_gold(GameManager.click_value * current_tier_index)
					spawn_floating_label("+" + str(GameManager.click_value * current_tier_index), event.position + Vector2(0, -20))
			BuildingType.PASSIVE:
				# Implement passive gold generation logic here
				pass
			BuildingType.MULTIPLIER:
				# Implement multiplier effect logic here
				pass

func spawn_floating_label(value: String, spawn_position: Vector2) -> void:
	var floating_label = floating_label_scene.instantiate()
	floating_label.setup(value)
	floating_label.global_position = spawn_position
	get_tree().current_scene.add_child(floating_label)

func _on_upgrade_label_pressed() -> void:
	if GameManager.spend_gold(upgrade_costs[current_tier_index]):
		upgrade()

func _on_gold_changed(new_gold: int) -> void:
	if current_tier_index < upgrade_costs.size() and new_gold >= upgrade_costs[current_tier_index]:
		upgrade_button.disabled = false
	else:
		upgrade_button.disabled = true

func _on_timer_timeout() -> void:
	if building_type == BuildingType.PASSIVE:
		if passive_rate > 0:
			GameManager.add_gold(passive_rate)
			spawn_floating_label("+" + str(passive_rate), gold_spawn_marker.global_position)

func _on_tier_mouse_exited() -> void:
	tooltip_timer.stop()
	GameManager.hide_tooltip.emit()

func _show_tooltip() -> void:
	GameManager.show_tooltip.emit(tooltip_text)
