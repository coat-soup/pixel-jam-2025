extends Node
class_name FarmingManager

@export var player : Player

var tilemap : TileMapLayer

var cur_fertiliser := 0


func _ready():
	tilemap = player.tilemap


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		fertilise()


func fertilise():
	var player_tile_pos = tilemap.local_to_map(player.position)
	tilemap.set_cell(player_tile_pos, 1, Vector2i.ZERO)


func add_fertiliser(amount := 1):
	cur_fertiliser += amount
	player.hud.set_fertiliser_count(cur_fertiliser)
	print("picked up fertiliser")
