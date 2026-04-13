extends Button
class_name UpgradeButton

@onready var value_label: Label = %ValueLabel

func set_cost(cost: int) -> void:
    value_label.text = str(cost)
