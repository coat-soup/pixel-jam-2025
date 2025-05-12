extends Node

@onready var pickup_trigger: Area2D = $PickupTrigger


func _ready() -> void:
	pickup_trigger.body_entered.connect(on_body_entered)


func on_body_entered(body: Node2D):
	print("entered fert")
	var player = body as Player
	if player:
		player = player.get_node("Farming") as FarmingManager
		player.add_fertiliser()
		queue_free()
