extends Node2D
class_name PlantBehaviour

var plant_data : Plant
@onready var enemy_collision: Area2D = $Area2D

var time_to_attack := 0.0


func _ready() -> void:
	print(enemy_collision.scale)
	enemy_collision.scale = Vector2(plant_data.range,plant_data.range)
	print(enemy_collision.scale)


func _process(delta: float) -> void:
	if plant_data.speed == 0:
		return
	if time_to_attack > 0:
		time_to_attack -= delta
	else:
		var enemies = enemy_collision.get_overlapping_bodies()
		for enemy in enemies:
			enemy = enemy as Enemy
			if enemy:
				attack(enemy)
				return


func attack(target : Node2D):
	await get_tree().create_timer(plant_data.attack_delay).timeout
	var attack_scene = plant_data.attack_scene.instantiate() as PlantAttack
	#attack_scene.position = position
	attack_scene.plant_data = plant_data
	attack_scene.target = target
	attack_scene.initialised = true
	add_child(attack_scene)
	time_to_attack = 1.0/plant_data.speed
