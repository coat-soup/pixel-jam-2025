extends Node
class_name GameManager

@export var hud : HUD
@export var shrine : Node2D
@export var shrine_hp := 100
@onready var cur_shrine_hp : int = shrine_hp
@export var player : Player

const ENEMY = preload("res://enemies/enemy.tscn")
@export var spawn_points : Array[Node2D]

var n_enemies := 3


func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	spawn_wave(n_enemies, 0)


func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func damage_shrine(amount : int):
	cur_shrine_hp -= amount
	(shrine.get_node("Label") as Label).text = str(cur_shrine_hp) + " HP"
	if cur_shrine_hp <= 0:
		print("GAME OVER")
		get_tree().quit()


func spawn_wave(num_enemies : int, dir : int):
	hud.display_wave(["NORTH", "EAST", "SOUTH", "WEST"][dir])
	
	for i in range(num_enemies):
		var enemy = ENEMY.instantiate() as Enemy
		enemy.game_manager = self
		spawn_points[dir].add_child(enemy)
		await get_tree().create_timer(5.0/float(num_enemies)).timeout
	
	await get_tree().create_timer(15.0).timeout
	num_enemies += 5
	spawn_wave(num_enemies, randi() % 4)
