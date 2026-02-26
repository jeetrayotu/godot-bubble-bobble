extends Node2D

const enemy = preload("res://scenes/enemy.tscn")
var enemies = 0
var rng = RandomNumberGenerator.new()
var max_enemies = rng.randi_range(3, 6)
var timer = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemies < max_enemies:
		timer += 1
		if timer % (60 * 1) == 0:
			enemies += 1
			add_child(enemy.instantiate())
