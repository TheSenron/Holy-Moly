
extends CharacterBody2D

@export var accel := 400.0
@export var brake := 600.0
@export var max_speed := 300.0
@export var rot_speed := 3.0

var speed := 0.0

func _ready() -> void:
    add_to_group("player")

func _physics_process(delta: float) -> void:
    # Rotation
    var turn := Input.get_action_strength("Right") - Input.get_action_strength("Left")
    rotation += turn * rot_speed * delta

    # Speed nach Input
    var drive := Input.get_action_strength("Up") - Input.get_action_strength("Down")
    if drive != 0.0:
        speed = clamp(speed + drive * accel * delta, -0.5 * max_speed, max_speed)
    else:
        speed = move_toward(speed, 0.0, brake * delta)

    var dir := Vector2.RIGHT.rotated(rotation)
    velocity = dir * speed

    move_and_slide()

    if get_slide_collision_count() > 0:
        speed = move_toward(velocity.length(), 0.0, 220.0 * delta)
    else:
        speed = velocity.length()





    # Bewegung in Blickrichtung
    var direction = Vector2.RIGHT.rotated(rotation)
    velocity = direction * speed
    move_and_slide()
