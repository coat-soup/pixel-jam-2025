extends Node
class_name FarmingManager

@export var player : Player

var tilemap : TileMapLayer

var cur_fertiliser := 0
var cur_seeds := 0
var cur_blood := 0

var cur_seed_id := 0

@export var available_plants : Array[Plant]

var planted_dict = {}

var grass_layer_source_ID = 3
var fertilised_layer_source_ID = 2

func _ready():
	tilemap = player.tilemap
	
	player.hud.initialise_plant_bar(available_plants)
	player.hud.set_selected_plant(cur_seed_id)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if get_cur_id() == fertilised_layer_source_ID:
			try_plant(available_plants[cur_seed_id])
		else:
			try_fertilise()
	
	var sp := 0
	if Input.is_action_just_released("next_plant"): sp = 1
	elif Input.is_action_just_released("prev_plant"): sp = -1
	if sp != 0:
		cur_seed_id = posmod((cur_seed_id - sp), len(available_plants))
		player.hud.set_selected_plant(cur_seed_id)
		print(cur_seed_id)


func try_plant(plant : Plant):
	var seed_id = available_plants.find(plant)
	var t_pos = tilemap.local_to_map(player.position)
	if cur_seeds <= 0:
		print("No seeds!")
		return
	elif get_cur_id() != fertilised_layer_source_ID:
		print("Not fertilised!")
		return
	elif planted_dict.has(t_pos):
		print("No space!")
		return
	elif cur_blood < plant.blood_cost:
		print("Not enough blood!")
		player.hud.warn_blood()
		return
	
	cur_blood -= plant.blood_cost
	cur_seeds -= 1
	player.hud.set_seeds_count(cur_seeds)
	player.hud.set_blood_count(cur_blood)
	
	var spawned = plant.prefab_scene.instantiate() as PlantBehaviour
	spawned.position = tilemap.map_to_local(t_pos)
	spawned.plant_data = plant
	player.plant_holder.add_child(spawned)
	planted_dict[t_pos] = spawned


func try_fertilise():
	if cur_fertiliser <= 0:
		print("No fertiliser!")
		return
	elif get_cur_id() != grass_layer_source_ID:
		print("Wrong tile!")
		return
	
	cur_fertiliser -= 1
	player.hud.set_fertiliser_count(cur_fertiliser)
	
	var player_tile_pos = tilemap.local_to_map(player.position)
	tilemap.set_cell(player_tile_pos, fertilised_layer_source_ID, Vector2i(1,1))


func add_fertiliser(amount := 1):
	cur_fertiliser += amount
	player.hud.set_fertiliser_count(cur_fertiliser)
	print("picked up fertiliser")


func add_seed(amount := 1):
	cur_seeds += amount
	player.hud.set_seeds_count(cur_seeds)
	print("picked up seed")


func add_blood(amount := 1):
	cur_blood += amount
	player.hud.set_blood_count(cur_blood)


func get_cur_tile() -> Vector2i:
	return tilemap.get_cell_atlas_coords(tilemap.local_to_map(player.position))

func get_cur_id() -> int:
	return tilemap.get_cell_source_id(tilemap.local_to_map(player.position))
