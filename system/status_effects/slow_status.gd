extends StatusEffect
class_name SlowStatus

@export var speed_multiplier := 0.5

func begin(enemy : Enemy):
	enemy.speed *= speed_multiplier
	enemy.frozen = true

func end(enemy : Enemy):
	enemy.speed /= speed_multiplier
	enemy.frozen = false

func tick(enemy : Enemy):
	pass
