extends Node2D
class_name PlantAttack

var plant_data : Plant
var target : Node2D
var speed := 500.0

var initialised := false

func _ready() -> void:
	(get_node("Area2D") as Area2D).body_entered.connect(on_body_entered)
	print("projectile spawned")


func _physics_process(delta: float) -> void:
	if !initialised: return
	if target == null:
		queue_free()
		return
	var dir = (target.global_position - global_position).normalized()
	
	position += dir * speed * delta


func on_body_entered(body : Node2D):
	body = body as Enemy
	if body:
		body.take_damage(plant_data.damage)
		queue_free()
