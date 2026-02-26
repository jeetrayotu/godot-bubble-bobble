extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const Bubble = preload("res://scripts/bubble.gd")
var ray: RayCast2D
var direction: int = 1

func _ready() -> void:
	ray = $CollisionShape2D/RayCast2D

func _process(delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.play("move_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("move_left")

func _physics_process(delta: float) -> void:

	# Adapted From: https://forum.godotengine.org/t/raycast2d-doesnt-collide-with-tilemap/19140/3
	ray.target_position = velocity * delta * 8

	ray.force_raycast_update()

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is TileMapLayer:
			if ray.get_collision_normal().x != 0:
				direction *= -1
		elif collider is Bubble and collider.get_node("AnimatedSprite2D").animation != "trap":
			collider.get_node("AnimatedSprite2D").play("trap")
			queue_free()
	velocity.x = direction * SPEED

	move_and_slide()
