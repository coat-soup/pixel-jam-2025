extends PlantAttack

@export var knockback := 0.0

func _ready() -> void:
	collider.scale *= plant_data.range
	var bodies = get_tree().get_nodes_in_group("enemies")
	# WARNING : collision detection refuses to work for some reason
	for body in bodies:
		body = body as Enemy
		var d = body.global_position - global_position
		if body and d.length() <= 16 * plant_data.range:
			body.take_damage(plant_data.damage)
			print("damaging fucker")
			body.knockback += d.normalized() * knockback
