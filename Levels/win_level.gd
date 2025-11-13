extends Control

@onready var time_label:  Label = get_node_or_null("VBoxContainer/TimeLabel")
@onready var coins_label: Label = get_node_or_null("VBoxContainer/CoinsLabel")
@onready var score_label: Label = get_node_or_null("VBoxContainer/ScoreLabel")

@export var coin_value: int = 1000             # Basis-Punkte pro Coin
@export var time_penalty_per_sec: int = 10     # Abzug pro Sekunde

func _ready() -> void:
    visible = false
    process_mode = Node.PROCESS_MODE_ALWAYS

func show_win() -> void:
    visible = true

    var time_ms: int = RunSession.get_run_time_ms()
    var coins: int = RunSession.total_coins
    var sec: int = int(round(time_ms / 1000.0))

    # Skill 5: +10% Punkte aus Coins
    var coin_score := int(round(coins * coin_value * RunSession.coin_score_multiplier()))
    var time_penalty := sec * time_penalty_per_sec
    var score := coin_score - time_penalty

    if time_label:
        time_label.text = "Time: %ds" % sec
    if coins_label:
        coins_label.text = "Coins: %d" % coins
    if score_label:
        score_label.text = "Score: %d" % score
