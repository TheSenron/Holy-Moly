extends Area2D

func _ready() -> void:
    if not body_entered.is_connected(_on_body_entered):
        body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
    if not body.is_in_group("player"):
        return

    var current := Flow.parse_level_number(get_tree().current_scene.scene_file_path)
    if current == -1:
        push_warning("Konnte Levelnummer nicht erkennen.")
        return

    var next := current + 1
    if next > Flow.LEVELS_TOTAL:
        Flow.go_to_game_win()
    else:
        Flow.next_level = next     # <- merken, welches Level nach dem SkillMenu kommt
        Flow.go_to_skill_menu()
