class_name Oil
extends Area2D

func _on_body_entered(body: Node2D) -> void:
    if body.is_in_group("player"):
        print("Öl")
        Signalbus.oil_destroyed.emit()
        self.queue_free()
