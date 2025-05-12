extends CharacterBody2D
class_name Enemy

@export var game_manager : GameManager
@export var speed := 50.0
@export var damage := 5
@export var attack_speed := 0.5

@export var max_health := 15
@onready var cur_health : int = max_health

var time_to_attack := 0.0


func _physics_process(delta: float) -> void:
	var dir := (game_manager.shrine.position - position).normalized()
	velocity = dir * speed
	move_and_slide()
	
	if time_to_attack > 0:
		time_to_attack -= delta
	elif position.distance_to(game_manager.shrine.position) <= 50.0:
		game_manager.damage_shrine(damage)
		time_to_attack = 1.0/attack_speed


func take_damage(amount : int):
	cur_health -= amount
	if cur_health <= 0:
		die()


func die():
	queue_free()
