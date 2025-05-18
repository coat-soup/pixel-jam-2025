extends PlantAttack

@export var status_effect : StatusEffect

func _ready() -> void:
	collider.body_entered.connect(on_body_entered)
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
		if status_effect:
			body.apply_status_effect(status_effect)
		queue_free()
