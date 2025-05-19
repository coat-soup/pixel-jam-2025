extends Node

@export var player : Player

@export var speed := 400.0

@onready var anim: AnimationPlayer = $"../WalkandIdle"
@onready var sprite: AnimatedSprite2D = $"../sprite container/AnimatedSprite2D"



func get_input() -> Vector2:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	return input_dir
	
	

func _physics_process(delta: float) -> void:
	player.velocity = get_input() * speed
	player.move_and_slide()
	
	if player.velocity.length() > 0:
		anim.play("PWalk")
	else:
		anim.play("PIdle")
	
	var v = player.velocity
	var dir = ("Up" if v.y < 0 else "Down") if abs(v.y) > abs(v.x) else ("Right" if v.x > 0 else "Left")
	sprite.play(dir)
