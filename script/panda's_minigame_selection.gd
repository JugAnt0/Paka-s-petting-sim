extends Node2D

var button_type = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$fade_transition/AnimationPlayer.play("fade_out")


func _on_texture_button_pressed() -> void:
	button_type = "ParkRun"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	


func _on_go_back_pressed() -> void:
	button_type = "GoBack"
	$fade_transition.show()
	$fade_transition/FadeTimer.start()
	$fade_transition/AnimationPlayer.play("fade_in")
	

func _on_fade_timer_timeout():
	if button_type == "ParkRun":
		
		get_tree().change_scene_to_file("res://scenes/panda's_automatic_platformer.tscn")
		
	elif button_type == "GoBack":
		get_tree().change_scene_to_file("res://scenes/indoor_blue_house.tscn")
	
