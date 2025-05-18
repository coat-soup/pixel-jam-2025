extends Node

@export var player : Player

@export var speed := 400.0

#@onready var playerSprite = $"../AnimatedSprite2D"


func get_input() -> Vector2:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	return input_dir
	
	

func _physics_process(delta: float) -> void:
	player.velocity = get_input() * speed
	player.move_and_slide()
	
	#if Input.is_action_pressed("left"):
		#playerSprite.play("PLeft")
	#if Input.is_action_pressed("right"):
		#playerSprite.play("PRight")
	#if Input.is_action_pressed("up"):
		#playerSprite.play("PUp")
	#if Input.is_action_pressed("down"):
		#playerSprite.play("PDown")
