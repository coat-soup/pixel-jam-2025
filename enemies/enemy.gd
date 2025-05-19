extends CharacterBody2D
class_name Enemy

@export var game_manager : GameManager
@export var speed := 50.0
@export var damage := 5
@export var attack_speed := 0.5

@export var max_health := 15
@onready var cur_health : int = max_health

var time_to_attack := 0.0

var knockback := Vector2.ZERO

var status_effects : Array[StatusEffect]
@onready var sprite: AnimatedSprite2D = $SpriteContainer/AnimatedSprite2D
const FERTILISER = preload("res://system/scenes/fertiliser.tscn")

var frozen := false


func _ready():
	tick_status_effects()


func tick_status_effects():
	var removals : Array[int] = []
	for i in range(len(status_effects)):
		status_effects[i].tick(self)
		status_effects[i].ticks_remaining -= 1
		if status_effects[i].ticks_remaining <= 0:
			removals.append(i)
	for i in range(len(removals) - 1, 0, -1):
		status_effects[i].end(self)
		status_effects.remove_at(i)
	await get_tree().create_timer(1.0).timeout
	tick_status_effects()
	

func apply_status_effect(e: StatusEffect):
	for effect in status_effects:
		if effect.is_class(e.get_class()):
			effect.ticks_remaining = max(effect.ticks_remaining, e.ticks_remaining)
			return
	status_effects.append(e)
	e.begin(self)


func _physics_process(delta: float) -> void:
	knockback = knockback.lerp(Vector2.ZERO, delta * 5.0)
	var dir := (game_manager.shrine.global_position - global_position).normalized()
	velocity = dir * speed if knockback.length() < 1  else knockback
	move_and_slide()
	
	if time_to_attack > 0:
		time_to_attack -= delta
	elif global_position.distance_to(game_manager.shrine.global_position) <= 50.0:
		game_manager.damage_shrine(damage)
		time_to_attack = 1.0/attack_speed
		
	var sprite_dir = ("Up" if velocity.y < 0 else "Down") if abs(velocity.y) > abs(velocity.x) else ("Right" if velocity.x > 0 else "Left")
	sprite.play(("E1" if !frozen else "F") + sprite_dir)


func take_damage(amount : int):
	cur_health -= amount
	var s = float(cur_health)/float(max_health)
	s = s/2 + 0.5
	scale = Vector2(s, s)
	print(scale)
	if cur_health <= 0:
		die()


func die():
	if randf() < 0.4:
		var fert = FERTILISER.instantiate()
		game_manager.add_child(fert)
		fert.global_position = global_position
	
	for plant in get_tree().get_nodes_in_group("bloodplant"):
		plant = plant as PlantBehaviour
		if plant.global_position.distance_to(global_position) <= plant.plant_data.range * 16:
			game_manager.player.farming.add_blood(1)
			continue
	queue_free()
