extends Resource
class_name Plant

@export var name : String
@export var prefab_scene : PackedScene
@export var sprite : Texture2D
@export var growth_time : float = 8.0
@export var blood_cost : int = 0
@export var range : float = 10
@export var damage : float = 7
@export var speed : float = 1
@export var attack_scene : PackedScene
@export var attack_delay := 0.0
