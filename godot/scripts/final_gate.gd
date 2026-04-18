extends Area2D

@onready var manager = %Manager

func _on_body_entered(body: Node2D) -> void:
	if manager.get_score() == 1:
		print("You win!")
		get_tree().change_scene_to_file("res://scenes/win_scene.tscn")

