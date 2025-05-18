extends Node2D
class_name PlantAttack

var plant_data : Plant
var target : Node2D
var speed := 500.0

var initialised := false

@export var collider : Area2D
