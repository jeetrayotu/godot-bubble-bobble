extends Area2D

var float_up: bool = false
const Player = preload("res://scripts/player.gd")
const bubble = preload("res://scenes/bubble.tscn")
const Bubble = preload("res://scripts/bubble.gd")
const enemy = preload("res://scenes/enemy.tscn")
var player: Player
var last_direction: float
var main
var trap: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main = get_node("/root/Main")
	player = main.get_node("Player")
	last_direction = player.last_direction
	$AnimatedSprite2D.play("creation")

	# Adapted From:
	# Answer: https://stackoverflow.com/a/72254446
	# User: https://stackoverflow.com/users/402022/theraot
	$HorizontalFloatTimer.connect(
		"timeout",
		_on_horizontal_float_timer_end
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !$AnimatedSprite2D.is_playing():
		$AnimatedSprite2D.play("standby")

func _physics_process(delta: float) -> void:
	if float_up:
		position.y -= 1
	else:
		position.x += last_direction

func _on_horizontal_float_timer_end():
	float_up = true

	if $AnimatedSprite2D.animation == "trap0":
		trap = true
		$AnimatedSprite2D.play("trap1")

	$DeathTimer.connect("timeout", _on_death_timer_end)
	$DeathTimer.start()

func _on_death_timer_end():
	$AnimatedSprite2D.play("pop")

	# Adapted From: https://www.reddit.com/r/godot/comments/1e9do9s/comment/ledo73d/
	await $AnimatedSprite2D.animation_finished

	if trap:
		var enemy_instance = enemy.instantiate()
		enemy_instance.position = position
		enemy_instance.version = 1
		main.add_child(enemy_instance)

	# Adapted From: https://www.reddit.com/r/godot/comments/cu2kwi/comment/exqlxjb/
	queue_free()
