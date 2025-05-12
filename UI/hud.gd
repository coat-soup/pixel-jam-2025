extends Control
class_name HUD

@export var fertiliser_label : Label


func set_fertiliser_count(amount: int):
	fertiliser_label.text = "Fertiliser: " + str(amount)
