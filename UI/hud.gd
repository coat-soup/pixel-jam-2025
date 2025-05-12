extends Control
class_name HUD

@export var fertiliser_label : Label
@export var seed_label : Label


func set_fertiliser_count(amount: int):
	fertiliser_label.text = "Fertiliser: " + str(amount)

func set_seed_count(amount: int):
	seed_label.text = "Seeds: " + str(amount)
