extends StatusEffect
class_name SlowStatus

@export var speed_multiplier := 0.5

func begin(enemy : Enemy):
	enemy.speed *= speed_multiplier
	#TODO: swap sprite

func end(enemy : Enemy):
	enemy.speed /= speed_multiplier
	#TODO: reset sprite

func tick(enemy : Enemy):
	pass
