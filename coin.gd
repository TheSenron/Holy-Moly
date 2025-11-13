class_name Coin
extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    for body in get_overlapping_bodies():
        if body.is_in_group("player"):
            Highscore.coins_collected += 1
            print(Highscore.coins_collected)
            RunSession.add_coins(1)
            self.queue_free()
