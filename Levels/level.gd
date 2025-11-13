extends Node2D

var coin: PackedScene = preload("res://scenes/coin.tscn")
@onready var drill: Drill = $Drill

@export var maxcoin: int = 20
var map_width = 6000
var map_height = 700
var min_distance = 100  # Mindestabstand zwischen Coins

func _ready() -> void:
    RunStats.start()
    spawn_coins()
    
func spawn_coins():
    var placed_coins = []

    for i in range(maxcoin):
        var attempts = 0
        var position_found = false
        var coin_pos = Vector2.ZERO

        while not position_found and attempts < 50:
            coin_pos = Vector2(
                randf_range(0, map_width),
                randf_range(-map_height/2, map_height/2)
            )
            
            position_found = true
            # Prüfe Abstand zu allen schon platzierten Coins
            for other_pos in placed_coins:
                if coin_pos.distance_to(other_pos) < min_distance:
                    position_found = false
                    break

            attempts += 1

        if position_found:
            var coin_instance: Coin = coin.instantiate()
            coin_instance.position = coin_pos
            add_child(coin_instance)
            placed_coins.append(coin_pos)
        else:
            print("Konnte keinen passenden Platz für Coin ", i, " finden.")
