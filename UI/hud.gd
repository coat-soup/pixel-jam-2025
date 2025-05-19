extends Control
class_name HUD

@export var fertiliser_label : Label
@export var seed_label : Label
@export var blood_label : Label
@export var plant_bar : Control
@export var seed_name_label : Label
@export var wave_label : Label

const BAR_SLOT_SPRITE = preload("res://UI/bar_slot_sprite.tscn")

var plants: Array[Plant]


func initialise_plant_bar(ps: Array[Plant]):
	plants = ps
	for p in plants:
		plant_bar.get_child(0).add_child(BAR_SLOT_SPRITE.instantiate())
		
		var icon = BAR_SLOT_SPRITE.instantiate()
		(icon.get_node("Sprite") as TextureRect).texture = p.sprite
		plant_bar.get_child(1).add_child(icon)


func set_selected_plant(id: int):
	for i in range(plant_bar.get_child(0).get_child_count()):
		(plant_bar.get_child(0).get_child(i).get_child(0) as Control).visible = i == id
	seed_name_label.text = plants[id].name


func set_fertiliser_count(amount: int):
	fertiliser_label.text = "Bones: " + str(amount)


func set_seeds_count(seeds: int):
	seed_label.text = "Seeds: " + str(seeds)


func set_blood_count(amount: int):
	blood_label.text = "Blood: " + str(amount)


func display_wave(dir_text : String = "somewhere probably"):
	wave_label.visible = true
	wave_label.text = "A WAVE IS COMING FROM THE " + dir_text
	await get_tree().create_timer(5.0).timeout
	wave_label.visible = false
