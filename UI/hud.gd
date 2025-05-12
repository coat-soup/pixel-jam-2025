extends Control
class_name HUD

@export var fertiliser_label : Label
@export var seed_label : Label
const BAR_SLOT_SPRITE = preload("res://UI/bar_slot_sprite.tscn")
@export var plant_bar : Control


func initialise_plant_bar(plants: Array[Plant]):
	for p in plants:
		plant_bar.get_child(0).add_child(BAR_SLOT_SPRITE.instantiate())
		
		var icon = BAR_SLOT_SPRITE.instantiate()
		(icon.get_node("Sprite") as TextureRect).texture = p.sprite
		plant_bar.get_child(1).add_child(icon)


func set_selected_plant(id: int):
	for i in range(plant_bar.get_child(0).get_child_count()):
		(plant_bar.get_child(0).get_child(i).get_child(0) as Control).visible = i == id


func set_fertiliser_count(amount: int):
	fertiliser_label.text = "Fertiliser: " + str(amount)


func set_seeds_count(plants: Array[Plant], seeds: Array[int]):
	seed_label.text = ""
	for i in range(len(plants)):
		seed_label.text += plants[i].name + " seeds: " + str(seeds[i]) + "\n"
