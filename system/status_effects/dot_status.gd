extends StatusEffect
class_name DOTStatus

@export var damage := 2

func begin(enemy : Enemy):
	#TODO: swap sprite
	pass

func end(enemy : Enemy):
	#TODO: reset sprite
	pass

func tick(enemy : Enemy):
	enemy.take_damage(damage)
	print(enemy, " taking ", damage, " tick damage")
