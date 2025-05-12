extends Node

@export var player : Player

@export var speed := 400.0


func get_input() -> Vector2:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	return input_dir

func _physics_process(delta: float) -> void:
	player.velocity = get_input() * speed
	player.move_and_slide()
