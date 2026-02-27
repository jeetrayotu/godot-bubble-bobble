extends CharacterBody2D

const SPEEDS: Dictionary[int, float] = {
	0: 300.0,
	1: 500.0,
}
const JUMP_VELOCITY = -400.0
const Bubble = preload("res://scripts/bubble.gd")
const Enemy = preload("res://scripts/enemy.gd")
var ray: RayCast2D
var direction: int = 1
var version: int = 0

func _ready() -> void:
	ray = $CollisionShape2D/RayCast2D

func _process(delta: float) -> void:
	if velocity.x > 0:
		$AnimatedSprite2D.play("move_right%s" % version)
	elif velocity.x < 0:
		$AnimatedSprite2D.play("move_left%s" % version)

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
		elif collider is Bubble and not collider.get_node(
			"AnimatedSprite2D"

		# Adapted From: https://godotforums.org/d/21919-string-manipulation-question/2
		).animation.begins_with("trap"):

			var bubble = collider.get_node("AnimatedSprite2D")
			if collider.float_up:
				collider.trap = true
				bubble.play("trap1")
			else:
				bubble.play("trap%s" % version)
			queue_free()
	velocity.x = direction * SPEEDS[version]

	move_and_slide()
