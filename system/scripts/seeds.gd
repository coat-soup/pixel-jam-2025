extends Node

@export var plant : Plant

@onready var pickup_trigger: Area2D = $PickupTrigger


func _ready() -> void:
	pickup_trigger.body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D):
	var player = body as Player
	if player:
		player = player.get_node("Farming") as FarmingManager
		player.add_seed(plant)
		queue_free()
