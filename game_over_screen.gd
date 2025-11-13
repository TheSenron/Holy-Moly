extends Control

@onready var bg: Control = get_node_or_null("GameOverBG")

func _ready() -> void:
    visible = false
    process_mode = Node.PROCESS_MODE_ALWAYS


func _on_play_again_pressed() -> void:
    get_tree().paused = false
    RunSession.start_new_run()  # Reset + neuer Start
    Flow.next_level = 1
    Flow.go_to_level(1)



func _on_main_menu_pressed() -> void:
    get_tree().paused = false
    RunSession.reset()
    get_tree().change_scene_to_file("res://main_menu.tscn") 
