extends CharacterBody2D

@export var speed: float = 300.0        
@export var turn_speed: float = 3.0     

var target_angle: float = float(NAN)

func _ready() -> void:
    add_to_group("player")

func _physics_process(delta: float) -> void:
    _update_desired_angle()

    if not is_nan(target_angle):
        var diff: float = wrapf(target_angle - rotation, -PI, PI)
        var max_step: float = turn_speed * delta
        var step: float = clamp(diff, -max_step, max_step)
        rotation += step

    var forward: Vector2 = Vector2.RIGHT.rotated(rotation)
    velocity = forward * speed
    move_and_slide()

func _update_desired_angle() -> void:
    # A wird hier komplett ignoriert – nur D zählt für "vorne"
    var x: float = Input.get_action_strength("Right")          # kein "- Left" mehr
    var y: float = Input.get_action_strength("Down") - Input.get_action_strength("Up")

    var input_vec := Vector2(x, y)

    if input_vec == Vector2.ZERO:
        target_angle = float(NAN)
        return

    input_vec = input_vec.normalized()
    target_angle = input_vec.angle()
