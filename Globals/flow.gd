extends Node

const LEVELS_TOTAL := 5
const LEVEL_DIR     := "res://Levels"
const SKILL_MENU    := "res://Levels/skill_tree_level.tscn"
const GAME_WIN      := "res://Levels/game_win.tscn"

var next_level: int = 1  # wird beim Start bzw. nach jedem Level gesetzt

func level_path(n: int) -> String:
    return "%s/level_%d.tscn" % [LEVEL_DIR, n]

func go_to_level(n: int) -> void:
    next_level = clamp(n, 1, LEVELS_TOTAL)
    get_tree().change_scene_to_file(level_path(next_level))

func go_to_skill_menu() -> void:
    get_tree().change_scene_to_file(SKILL_MENU)

func go_to_game_win() -> void:
    get_tree().change_scene_to_file(GAME_WIN)

func parse_level_number(path: String) -> int:
    var re := RegEx.new()
    re.compile("level_(\\d+)\\.tscn$")
    var m := re.search(path)
    return int(m.get_string(1)) if m else -1
