extends Node
class_name FarmingManager

@export var player : Player

var tilemap : TileMapLayer

var cur_fertiliser := 0
var cur_seeds : Array[int]

var cur_seed_id := 0

@export var available_plants : Array[Plant]

var planted_dict = {}


func _ready():
	tilemap = player.tilemap
	for i in range(len(available_plants)):
		cur_seeds.append(0)
	
	player.hud.initialise_plant_bar(available_plants)
	player.hud.set_selected_plant(cur_seed_id)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if get_cur_tile() == Vector2i(0,0):
			try_plant(available_plants[cur_seed_id])
		else:
			try_fertilise()
	
	var sp := 0
	if Input.is_action_just_released("next_plant"): sp = 1
	elif Input.is_action_just_released("prev_plant"): sp = -1
	if sp != 0:
		cur_seed_id = posmod((cur_seed_id + sp), len(available_plants))
		player.hud.set_selected_plant(cur_seed_id)
		print(cur_seed_id)


func try_plant(plant : Plant):
	var seed_id = available_plants.find(plant)
	var t_pos = tilemap.local_to_map(player.position)
	if cur_seeds[seed_id] <= 0:
		print("No seeds!")
		return
	elif get_cur_tile() != Vector2i(0,0):
		print("Not fertilised!")
		return
	elif planted_dict.has(t_pos):
		print("No space!")
		return
	
	cur_seeds[seed_id] -= 1
	player.hud.set_seeds_count(available_plants, cur_seeds)
	
	var spawned = plant.prefab_scene.instantiate() as PlantBehaviour
	spawned.position = tilemap.map_to_local(t_pos)
	spawned.plant_data = plant
	player.plant_holder.add_child(spawned)
	planted_dict[t_pos] = spawned


func try_fertilise():
	if cur_fertiliser <= 0:
		print("No fertiliser!")
		return
	elif get_cur_tile() != Vector2i(0,1):
		print("Wrong tile!")
		return
	
	cur_fertiliser -= 1
	player.hud.set_fertiliser_count(cur_fertiliser)
	
	var player_tile_pos = tilemap.local_to_map(player.position)
	tilemap.set_cell(player_tile_pos, 1, Vector2i.ZERO)


func add_fertiliser(amount := 1):
	cur_fertiliser += amount
	player.hud.set_fertiliser_count(cur_fertiliser)
	print("picked up fertiliser")


func add_seed(plant : Plant, amount := 1):
	cur_seeds[available_plants.find(plant)] += amount
	player.hud.set_seeds_count(available_plants, cur_seeds)
	print("picked up seed")


func get_cur_tile() -> Vector2i:
	return tilemap.get_cell_atlas_coords(tilemap.local_to_map(player.position))
