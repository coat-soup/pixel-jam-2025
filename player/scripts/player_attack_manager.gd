extends Node

@export var damage := 9
@export var attack_speed := 1.3
@export var particles : PackedScene

@onready var attack_collision: Area2D = $AttackCollision
@onready var anim: AnimationPlayer = $"../AttackAnim"

var attack_timer := 0.0


func _process(delta: float) -> void:
	if attack_timer > 0:
		attack_timer -= delta


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack()


func attack():
	if attack_timer > 0:
		return
	#add_child(particles.instantiate())
	anim.play("PAttack")
	attack_timer = 1.0/attack_speed
	
	var bodies = attack_collision.get_overlapping_bodies()
	for enemy in bodies:
		enemy = enemy as Enemy
		if enemy:
			enemy.take_damage(damage)
