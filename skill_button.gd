extends TextureButton
class_name SkillNode

@export var skill_id: int = 0          # 1..6
@export var cost: int = 10             # Kosten in Coins

var unlocked: bool = false

@onready var panel: Panel = $Panel
@onready var label: Label = $MarginContainer/SkillLabel
@onready var line_2d: Line2D = $SkillBranch

var level: int = 0:
    set(value):
        level = value
        if label:
            label.text = str(level) + "/1"


func _ready() -> void:
    # Linie zum Parent zeichnen
    if get_parent() is SkillNode:
        line_2d.clear_points()
        line_2d.add_point(global_position + size / 2.0)
        line_2d.add_point(get_parent().global_position + get_parent().size / 2.0)

    # Kinder zu Beginn sperren, falls dieser Skill noch nicht gekauft ist
    if level == 0:
        for child in get_children():
            if child is SkillNode:
                child.disabled = true

    if not pressed.is_connected(_on_pressed):
        pressed.connect(_on_pressed)

    _update_visual()


func _on_pressed() -> void:

    if unlocked:
        return


    if not RunSession.can_afford(cost):
        print("Not enough coins! Need ", cost, ", have ", RunSession.coins_for_skills)
        return


    if not RunSession.buy_skill(cost):
        print("Coin payment failed unexpectedly.")
        return


    unlocked = true
    level = 1
    panel.show_behind_parent = true
    line_2d.default_color = Color(1, 1, 0.25)

    RunSession.unlock_skill(skill_id)


    for child in get_children():
        if child is SkillNode:
            child.disabled = false

    _update_visual()


func _update_visual() -> void:
    modulate.a = 1.0 if unlocked else 0.5
