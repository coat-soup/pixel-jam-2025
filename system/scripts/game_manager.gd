extends Node
class_name GameManager

@export var hud : HUD
@export var shrine : Node2D
@export var shrine_hp := 100
@onready var cur_shrine_hp : int = shrine_hp


func _input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func damage_shrine(amount : int):
	cur_shrine_hp -= amount
	(shrine.get_node("Label") as Label).text = str(cur_shrine_hp) + " HP"
	if cur_shrine_hp <= 0:
		print("GAME OVER")
		get_tree().quit()
