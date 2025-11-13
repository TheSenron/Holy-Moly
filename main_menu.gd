extends Control



func _on_start_button_pressed():
    RunSession.start_new_run()
    Flow.next_level = 1
    Flow.go_to_level(1)

func _on_quit_button_pressed():
    get_tree().quit()
