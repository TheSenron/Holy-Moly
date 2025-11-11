extends Area2D

@export var base_speed: float = 140.0      
@export var catchup_speed: float = 220.0   
@export var safe_margin: float = 260.0     
@export var follow_y: bool = true
@export var y_follow_strength: float = 4.0

var player: Node2D

func _ready() -> void:
    player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
    if player == null:
        player = get_tree().get_first_node_in_group("player")
        if player == null: return

    var target_x: float = player.global_position.x - safe_margin
    var dist_x: float = target_x - global_position.x
    var catchup_factor: float = clampf(absf(dist_x) / max(safe_margin, 0.001), 0.0, 1.0)

    var max_step: float = (base_speed + catchup_speed * catchup_factor) * delta
    global_position.x = move_toward(global_position.x, target_x, max_step)


    for body in get_overlapping_bodies():
        if body.is_in_group("player"):
            get_tree().reload_current_scene()

        
# Drill zu Player Interaktion
func _on_Drill_body_entered(body: Node) -> void:
    if body.is_in_group("player"):
        get_tree().reload_current_scene()  #GameOver
