extends Node2D

@onready var timer: Timer = $Timer

func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_ready() -> void:
	timer.start()
