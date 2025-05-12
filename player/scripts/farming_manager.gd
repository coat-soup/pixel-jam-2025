extends Node
class_name FarmingManager

@export var player : Player

var tilemap : TileMapLayer

var cur_fertiliser := 0
var cur_seeds := 0


var plant_dict = {}

const PLANT_PROTOTYPE = preload("res://plants/plant_prototype.tscn")


func _ready():
	tilemap = player.tilemap


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if get_cur_tile() == Vector2i(0,0):
			try_plant()
		else:
			try_fertilise()


func try_plant():
	print(plant_dict)
	var t_pos = tilemap.local_to_map(player.position)
	if cur_seeds <= 0:
		print("No seeds!")
		return
	elif get_cur_tile() != Vector2i(0,0):
		print("Not fertilised!")
		return
	elif plant_dict.has(t_pos):
		print("No space!")
		return
	
	cur_seeds -= 1
	player.hud.set_seed_count(cur_seeds)
	
	var plant = PLANT_PROTOTYPE.instantiate()
	plant.position = tilemap.map_to_local(t_pos)
	player.plant_holder.add_child(plant)
	plant_dict[t_pos] = plant

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


func add_seed(amount := 1):
	cur_seeds += amount
	player.hud.set_seed_count(cur_seeds)
	print("picked up seed")

func get_cur_tile() -> Vector2i:
	return tilemap.get_cell_atlas_coords(tilemap.local_to_map(player.position))
