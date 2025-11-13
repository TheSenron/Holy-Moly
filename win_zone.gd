# WinZone.gd (Area2D)
extends Area2D

@export var win_ui_path: NodePath = ^"CanvasLayer2/WinScreen"
const COIN_VALUE := 1000
const TIME_PENALTY_PER_SEC := 10

var _won := false

func _ready() -> void:
    if not body_entered.is_connected(_on_body_entered):
        body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
    if _won: return
    if not body.is_in_group("player"): return
    _won = true
    _player_won()

func _player_won() -> void:
    var time_ms: int = RunStats.elapsed_ms()
    var seconds: int = int(round(time_ms / 1000.0))
    var coins: int = Highscore.coins_collected

    var score: int = coins * COIN_VALUE - seconds * TIME_PENALTY_PER_SEC

    var ui := get_tree().current_scene.get_node_or_null(win_ui_path)
    if ui:
        if ui.has_method("show_win"):
            ui.call("show_win", time_ms, coins, score)
        else:
            ui.show()
    get_tree().paused = true
