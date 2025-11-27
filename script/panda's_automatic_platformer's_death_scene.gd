extends Node2D

var button_type = null


	


func _ready() -> void:
	$fade_transition/AnimationPlayer.play("fade_out")


	




func _on_retry_pressed() -> void:
	button_type = "retry"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")


func _on_go_back_pressed() -> void:
	button_type = "back"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")

func _on_fade_timer_timeout() -> void:
	if button_type == "retry":
		get_tree().change_scene_to_file("res://scenes/panda's_automatic_platformer.tscn")
		
	elif button_type == "back":
		get_tree().change_scene_to_file("res://scenes/panda's_minigame_selection.tscn")
