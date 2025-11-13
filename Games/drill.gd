class_name Drill

extends Area2D

@export var base_speed: float = 140.0      
@export var catchup_speed: float = 220.0   
@export var safe_margin: float = 260.0     
@export var follow_y: bool = true
@export var y_follow_strength: float = 4.0
@export var speed_boost: float = 1.5
@export var speed_duration: float = 2.0
var current_speed_modifier: float = 1.0
var speedboost_timer: Timer

var player: Node2D

func _ready() -> void:
    #Initializing the timer
    speedboost_timer = Timer.new()
    add_child(speedboost_timer)
    speedboost_timer.wait_time = speed_duration
    speedboost_timer.one_shot = true
    speedboost_timer.timeout.connect(_on_speedboost_end)
    
    
    Signalbus.oil_destroyed.connect(_on_oil_destroyed)
    player = get_tree().get_first_node_in_group("player")

var _dead: bool = false

func _physics_process(delta: float) -> void:
    # --- Wenn tot → keine Bewegung oder Kollision prüfen
    if _dead:
        return

    # --- Player nachfassen
    if player == null:
        player = get_tree().get_first_node_in_group("player")
        if player == null:
            return

    # --- Drill-Bewegung
    var target_x: float = player.global_position.x - safe_margin
    var dist_x: float = target_x - global_position.x
    var catchup_factor: float = clampf(absf(dist_x) / max(safe_margin, 0.001), 0.0, 1.0)

    var max_step: float = (base_speed + catchup_speed * catchup_factor * current_speed_modifier) * delta
    global_position.x = move_toward(global_position.x, target_x, max_step)

    # --- Overlap-Check (wenn Signal nicht feuert)
    for body in get_overlapping_bodies():
        if body.is_in_group("player"):
            death()
            break


func _on_Drill_body_entered(body: Node) -> void:
    if _dead:
        return
    if body.is_in_group("player"):
        death()


func death() -> void:
    _dead = true
    Highscore.coins_collected = 0

    var root := get_tree().current_scene
    var ui := root.get_node_or_null("CanvasLayer2/GameOverScreen")
    if ui:
        var cl := ui.get_parent()
        if cl is CanvasLayer:
            cl.layer = max(cl.layer, 10)

        # Fullscreen/zentriert + sichtbar + oben
        ui.visible = true
        ui.modulate.a = 1.0
        ui.z_index = 1000
        ui.anchor_left = 0.0
        ui.anchor_top = 0.0
        ui.anchor_right = 1.0
        ui.anchor_bottom = 1.0
        ui.position = Vector2.ZERO
        ui.size = get_viewport_rect().size
    else:
        push_warning("GameOver UI nicht gefunden: CanvasLayer2/GameOverScreen")

    # Spieler einfrieren
    var p := get_tree().get_first_node_in_group("player")
    if p:
        if p.has_method("set_physics_process"): p.set_physics_process(false)
        if p.has_method("set_process_input"):   p.set_process_input(false)




func _on_oil_destroyed() -> void:
    if speedboost_timer.time_left > 0:
        speedboost_timer.start(speed_duration)
    else:
        speedboost_timer.start()
    current_speed_modifier = speed_boost
    
func _on_speedboost_end() -> void:
    current_speed_modifier = 1.0
    
    #make speed go normal
    
