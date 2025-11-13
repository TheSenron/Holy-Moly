extends Control

@onready var time_label:  Label = get_node_or_null("VBoxContainer/TimeLabel")
@onready var coins_label: Label = get_node_or_null("VBoxContainer/CoinsLabel")
@onready var score_label: Label = get_node_or_null("VBoxContainer/ScoreLabel")

func _ready() -> void:
    visible = false
    process_mode = Node.PROCESS_MODE_ALWAYS  # bleibt klickbar bei Pause

func show_win(time_ms: int, coins: int, score: int) -> void:
    visible = true
    var sec := int(round(time_ms / 1000.0))
    if time_label:  time_label.text  = "Time: %ds" % sec
    if coins_label: coins_label.text = "Coins: %d" % coins
    if score_label: score_label.text = "Score: %d" % score
