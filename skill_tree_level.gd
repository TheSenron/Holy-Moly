extends Control

@onready var next_btn: BaseButton = $NextLevel  # <— normales $ statt %

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS
    next_btn.pressed.connect(_on_next_pressed)

func _on_next_pressed() -> void:
    var n := Flow.next_level
    var path := Flow.level_path(n)
    if get_tree().paused: get_tree().paused = false
    if FileAccess.file_exists(path):
        get_tree().change_scene_to_file(path)
    else:
        Flow.go_to_game_win()
