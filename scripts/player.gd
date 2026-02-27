extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const bubble = preload("res://scenes/bubble.tscn")
const Bubble = preload("res://scripts/bubble.gd")
var bubbles: Array[Bubble] = []
var main
var last_direction: float = 1.0
var ray: RayCast2D

func _ready() -> void:
	ray = $CollisionShape2D/RayCast2D
	main = get_node("/root/Main")

func animate_defaults():
	if velocity.x > 0:
		if velocity.y:
			$AnimatedSprite2D.play("jump_right")
		else:
			$AnimatedSprite2D.play("run_right")
	elif velocity.x < 0:
		if velocity.y:
			$AnimatedSprite2D.play("jump_left")
		else:
			$AnimatedSprite2D.play("run_left")
	elif velocity.y:
		$AnimatedSprite2D.play("fall")
	else:
		$AnimatedSprite2D.play("still")

# Adapted From: https://www.reddit.com/r/godot/comments/1i9yrpg/comment/m965lmh/
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):
		$AnimatedSprite2D.play(
			"blow_left" if last_direction < 0 else "blow_right"
		)

	# Adapted From: https://forum.godotengine.org/t/how-do-i-check-if-a-particular-animation-in-an-animationplayer-is-playing-or-not/28880/4
	# And: https://godotforums.org/d/21919-string-manipulation-question/2
	if $AnimatedSprite2D.animation.begins_with("blow"):
		if not $AnimatedSprite2D.is_playing():
			animate_defaults()
	else:
		animate_defaults()

func _physics_process(delta: float) -> void:
	# Adapted From: https://forum.godotengine.org/t/raycast2d-doesnt-collide-with-tilemap/19140/3
	ray.target_position = velocity * delta

	ray.force_raycast_update()

	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is Bubble:
			collider._on_death_timer_end()
			if not bubbles.is_empty():
				for b in bubbles:
					if b != null:
						b._on_death_timer_end()
				bubbles = []

	if Input.is_action_just_pressed("fire"):
		var bubble_instance: Bubble = bubble.instantiate()
		bubbles.append(bubble_instance)
		main.add_child(bubble_instance)
		bubble_instance.position = Vector2(
			position.x + (last_direction * 100),
			position.y
		)

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	else:
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		last_direction = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
